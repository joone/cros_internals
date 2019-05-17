```C++
void Compositor::SetVisible(bool visible) {
  host_->SetVisible(visible);
  // Visibility is reset when the output surface is lost, so this must also be
  // updated then.
  // TODO(fsamuel): Eliminate this call.
  if (context_factory_private_)
    context_factory_private_->SetDisplayVisible(this, visible);
}
```


```C++


void ProxyMain::BeginMainFrame(
..
 layer_tree_host_->WillBeginMainFrame();
  layer_tree_host_->RecordStartOfFrameMetrics();

  // See LayerTreeHostClient::BeginMainFrame for more documentation on
  // what this does.
  layer_tree_host_->BeginMainFrame(begin_main_frame_state->begin_frame_args);
..
}

void LayerTreeHost::BeginMainFrame(const viz::BeginFrameArgs& args) {
  client_->BeginMainFrame(args);
}


void LayerTreeView::BeginMainFrame(const viz::BeginFrameArgs& args) {
  web_main_thread_scheduler_->WillBeginFrame(args);
  delegate_->BeginMainFrame(args.frame_time);
}


void RenderWidget::BeginMainFrame(base::TimeTicks frame_time) {
  if (!GetWebWidget())
    return;

  // We record metrics only when running in multi-threaded mode, not
  // single-thread mode for testing.
  bool record_main_frame_metrics =
      !!compositor_deps_->GetCompositorImplThreadTaskRunner();
  if (input_event_queue_) {
    base::Optional<ScopedUkmRafAlignedInputTimer> ukm_timer;
    if (record_main_frame_metrics)
      ukm_timer.emplace(GetWebWidget());
    input_event_queue_->DispatchRafAlignedInput(frame_time);
  }

  GetWebWidget()->BeginFrame(frame_time, record_main_frame_metrics);
}

void WebFrameWidgetImpl::BeginFrame(base::TimeTicks last_frame_time,
                                    bool record_main_frame_metrics) {
  TRACE_EVENT1("blink", "WebFrameWidgetImpl::beginFrame", "frameTime",
               last_frame_time);
  DCHECK(!last_frame_time.is_null());

  if (!LocalRootImpl())
    return;

  DocumentLifecycle::AllowThrottlingScope throttling_scope(
      LocalRootImpl()->GetFrame()->GetDocument()->Lifecycle());
  if (record_main_frame_metrics) {
    SCOPED_UMA_AND_UKM_TIMER(
        LocalRootImpl()->GetFrame()->View()->EnsureUkmAggregator(),
        LocalFrameUkmAggregator::kAnimate);
    PageWidgetDelegate::Animate(*GetPage(), last_frame_time);
  } else {
    PageWidgetDelegate::Animate(*GetPage(), last_frame_time);
  }
  // Animate can cause the local frame to detach.
  if (LocalRootImpl())
    GetPage()->GetValidationMessageClient().LayoutOverlay();
}
```
