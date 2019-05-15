content/browser/browser_main_loop.cc

```c++

int BrowserMainLoop::BrowserThreadsStarted() {

  if (features::IsVizDisplayCompositorEnabled()) {
    auto transport_factory = std::make_unique<VizProcessTransportFactory>(
        BrowserGpuChannelHostFactory::instance(), GetResizeTaskRunner(),
        compositing_mode_reporter_impl_.get());
    transport_factory->ConnectHostFrameSinkManager();
    ImageTransportFactory::SetFactory(std::move(transport_factory));
  } else {
    server_shared_bitmap_manager_ =
        std::make_unique<viz::ServerSharedBitmapManager>();
    viz::FrameSinkManagerImpl::InitParams params;
    params.shared_bitmap_manager = server_shared_bitmap_manager_.get();
    params.activation_deadline_in_frames =
        switches::GetDeadlineToSynchronizeSurfaces();
    frame_sink_manager_impl_ =
        std::make_unique<viz::FrameSinkManagerImpl>(params);

    surface_utils::ConnectWithLocalFrameSinkManager(
        host_frame_sink_manager_.get(), frame_sink_manager_impl_.get(),
        base::ThreadTaskRunnerHandle::Get());

    ImageTransportFactory::SetFactory(
        std::make_unique<GpuProcessTransportFactory>(
            BrowserGpuChannelHostFactory::instance(),
            compositing_mode_reporter_impl_.get(),
            server_shared_bitmap_manager_.get(), GetResizeTaskRunner()));
  }
  ...
}

