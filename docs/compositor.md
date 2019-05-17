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
 // Inform the display corresponding to this compositor if it is visible. When
  // false it does not need to produce any frames. Visibility is reset for each
  // call to CreateLayerTreeFrameSink.
  virtual void SetDisplayVisible(ui::Compositor* compositor, bool visible) = 0;
```
  
```C++
void HostContextFactoryPrivate::SetDisplayVisible(Compositor* compositor,
                                                  bool visible) {
  auto iter = compositor_data_map_.find(compositor);
  if (iter == compositor_data_map_.end() || !iter->second.display_private)
    return;
  iter->second.display_private->SetDisplayVisible(visible);
}
```

```C++
void DisplayPrivateProxy::SetDisplayVisible(
    bool in_visible) {
#if BUILDFLAG(MOJO_TRACE_ENABLED)
  TRACE_EVENT0("mojom", "<class 'jinja2::utils::Namespace'>::DisplayPrivate::SetDisplayVisible");
#endif
  const bool kExpectsResponse = false;
  const bool kIsSync = false;
  
  const uint32_t kFlags =
      ((kExpectsResponse) ? mojo::Message::kFlagExpectsResponse : 0) |
      ((kIsSync) ? mojo::Message::kFlagIsSync : 0);
  
  mojo::Message message(
      internal::kDisplayPrivate_SetDisplayVisible_Name, kFlags, 0, 0, nullptr);
  auto* buffer = message.payload_buffer();
  ::viz::mojom::internal::DisplayPrivate_SetDisplayVisible_Params_Data::BufferWriter
      params;
  mojo::internal::SerializationContext serialization_context;
  params.Allocate(buffer);
  params->visible = in_visible;
  message.AttachHandlesFromSerializationContext(
      &serialization_context);

#if defined(ENABLE_IPC_FUZZER)
  message.set_interface_name(DisplayPrivate::Name_);
  message.set_method_name("SetDisplayVisible");
#endif
  // This return value may be ignored as false implies the Connector has
  // encountered an error, which will be visible through other means.
  ignore_result(receiver_->Accept(&message));
}
