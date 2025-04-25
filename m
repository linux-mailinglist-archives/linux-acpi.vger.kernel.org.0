Return-Path: <linux-acpi+bounces-13297-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B171FA9D1CA
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Apr 2025 21:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F060C4E4562
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Apr 2025 19:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE728233702;
	Fri, 25 Apr 2025 19:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="URFMfzVY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A86226CE6;
	Fri, 25 Apr 2025 19:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745609671; cv=none; b=lqljdHzHB0801tp1HXvLJ4A576ZHMHj0+Zbwc81VdDjZu6Xg8QQVtW40/ukwM4WODjqhbHXzb2lJUEfrSJOzfLrLozmf4W1hoeZLJUQxXZUpQI3wlHwmbvABaOC+fAn5bOOlmmladlu5sFMpGJN90PwQlqv9d03S8TV5e31WPFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745609671; c=relaxed/simple;
	bh=yT3yswzEN0GV5dHvoRPkV+DIV3Gy/OG2OAXlTbBuMVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CbykvYn7FlLGJOtPnBU8SMug50wHPYDhGogHthQfDWo0IrDV1xUrATJ6dEHiIAga6QuXNMA8kkhKlDHlR506+TOcTRBPWMk7komkPyGLK7kz9kHdD5uEQhRiooGXCuzsa2lglAmp/eIIJnsD65hz+Bh7FkrJN5kkYukdE4OyKrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=URFMfzVY; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [217.114.34.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 168A76643E6;
	Fri, 25 Apr 2025 21:34:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1745609666;
	bh=yT3yswzEN0GV5dHvoRPkV+DIV3Gy/OG2OAXlTbBuMVc=;
	h=From:Subject:Date;
	b=URFMfzVYWpvkWWgDWgTdaKcSVAPrUMr4IkMqJ8cfHbEDYBXUD7XTSGf1LYxEYU0MX
	 08x7L84bdPI7g/aWbYlbGYF67nVGVfmg2W9kzKHJFpzxPzUrFs85KFHuuLGkxRYLfp
	 0h6IjqHeLD5OPv86TCZRKDQkkbJXtSknSQESNj9x+IFupwBaaBrFqsh9dMTxvvOk9y
	 9YnVwdcWUxKc1sS6KzRWPswplEZFFvM7qCAHkrcX+89DiST33LKwn2F+pY4plyrnDd
	 Dqzqj0gzIvTkbifFNvKL7fdUVNOJyRTvtuQhyhz/iVz3Klng6wRwufQZrpR6ZmW42c
	 gr9P+Mno+s5PQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Bob Moore <robert.moore@intel.com>,
 Saket Dumbre <saket.dumbre@intel.com>
Subject: [PATCH v1 02/19] ACPICA: Apply pack(1) to union aml_resource
Date: Fri, 25 Apr 2025 21:21:05 +0200
Message-ID: <4664267.LvFx2qVVIh@rjwysocki.net>
In-Reply-To: <12671029.O9o76ZdvQC@rjwysocki.net>
References: <12671029.O9o76ZdvQC@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 217.114.34.19
X-CLIENT-HOSTNAME: 217.114.34.19
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvheefudelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtqhertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepleeivdeuffdtffegueffhfeghfegudevkefgtdfggeevjeeljefhlefhgffhjefhnecuffhomhgrihhnpehgihhthhhusgdrtghomhdprghsrghnrdhsohdprgguughrvghsshdrihhnfhhonecukfhppedvudejrdduudegrdefgedrudelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddujedruddugedrfeegrdduledphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepgedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgsvghrthdrmhhoohhrvgesihhnthgvlhdrtghomhdprhgtphhtthhopehsrghkvghtrdguuhhmsgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

=46rom: Tamir Duberstein <tamird@gmail.com>

ACPICA commit 1c28da2242783579d59767617121035dafba18c3

This was originally done in NetBSD:
https://github.com/NetBSD/src/commit/b69d1ac3f7702f67edfe412e4392f77d098049=
10
and is the correct alternative to the smattering of `memcpy`s I
previously contributed to this repository.

This also sidesteps the newly strict checks added in UBSAN:
https://github.com/llvm/llvm-project/commit/792674400f6f04a074a3827349ed0e2=
ac10067f6

Before this change we see the following UBSAN stack trace in Fuchsia:

  #0    0x000021afcfdeca5e in acpi_rs_get_address_common(struct acpi_resour=
ce*, union aml_resource*) ../../third_party/acpica/source/components/resour=
ces/rsaddr.c:329 <platform-bus-x86.so>+0x6aca5e
  #1.2  0x000021982bc4af3c in ubsan_get_stack_trace() compiler-rt/lib/ubsan=
/ubsan_diag.cpp:41 <libclang_rt.asan.so>+0x41f3c
  #1.1  0x000021982bc4af3c in maybe_print_stack_trace() compiler-rt/lib/ubs=
an/ubsan_diag.cpp:51 <libclang_rt.asan.so>+0x41f3c
  #1    0x000021982bc4af3c in ~scoped_report() compiler-rt/lib/ubsan/ubsan_=
diag.cpp:395 <libclang_rt.asan.so>+0x41f3c
  #2    0x000021982bc4bb6f in handletype_mismatch_impl() compiler-rt/lib/ub=
san/ubsan_handlers.cpp:137 <libclang_rt.asan.so>+0x42b6f
  #3    0x000021982bc4b723 in __ubsan_handle_type_mismatch_v1 compiler-rt/l=
ib/ubsan/ubsan_handlers.cpp:142 <libclang_rt.asan.so>+0x42723
  #4    0x000021afcfdeca5e in acpi_rs_get_address_common(struct acpi_resour=
ce*, union aml_resource*) ../../third_party/acpica/source/components/resour=
ces/rsaddr.c:329 <platform-bus-x86.so>+0x6aca5e
  #5    0x000021afcfdf2089 in acpi_rs_convert_aml_to_resource(struct acpi_r=
esource*, union aml_resource*, struct acpi_rsconvert_info*) ../../third_par=
ty/acpica/source/components/resources/rsmisc.c:355 <platform-bus-x86.so>+0x=
6b2089
  #6    0x000021afcfded169 in acpi_rs_convert_aml_to_resources(u8*, u32, u3=
2, u8, void**) ../../third_party/acpica/source/components/resources/rslist.=
c:137 <platform-bus-x86.so>+0x6ad169
  #7    0x000021afcfe2d24a in acpi_ut_walk_aml_resources(struct acpi_walk_s=
tate*, u8*, acpi_size, acpi_walk_aml_callback, void**) ../../third_party/ac=
pica/source/components/utilities/utresrc.c:237 <platform-bus-x86.so>+0x6ed2=
4a
  #8    0x000021afcfde66b7 in acpi_rs_create_resource_list(union acpi_opera=
nd_object*, struct acpi_buffer*) ../../third_party/acpica/source/components=
/resources/rscreate.c:199 <platform-bus-x86.so>+0x6a66b7
  #9    0x000021afcfdf6979 in acpi_rs_get_method_data(acpi_handle, const ch=
ar*, struct acpi_buffer*) ../../third_party/acpica/source/components/resour=
ces/rsutils.c:770 <platform-bus-x86.so>+0x6b6979
  #10   0x000021afcfdf708f in acpi_walk_resources(acpi_handle, char*, acpi_=
walk_resource_callback, void*) ../../third_party/acpica/source/components/r=
esources/rsxface.c:731 <platform-bus-x86.so>+0x6b708f
  #11   0x000021afcfa95dcf in acpi::acpi_impl::walk_resources(acpi::acpi_im=
pl*, acpi_handle, const char*, acpi::Acpi::resources_callable) ../../src/de=
vices/board/lib/acpi/acpi-impl.cc:41 <platform-bus-x86.so>+0x355dcf
  #12   0x000021afcfaa8278 in acpi::device_builder::gather_resources(acpi::=
device_builder*, acpi::Acpi*, fidl::any_arena&, acpi::Manager*, acpi::devic=
e_builder::gather_resources_callback) ../../src/devices/board/lib/acpi/devi=
ce-builder.cc:84 <platform-bus-x86.so>+0x368278
  #13   0x000021afcfbddb87 in acpi::Manager::configure_discovered_devices(a=
cpi::Manager*) ../../src/devices/board/lib/acpi/manager.cc:75 <platform-bus=
=2Dx86.so>+0x49db87
  #14   0x000021afcf99091d in publish_acpi_devices(acpi::Manager*, zx_devic=
e_t*, zx_device_t*) ../../src/devices/board/drivers/x86/acpi-nswalk.cc:95 <=
platform-bus-x86.so>+0x25091d
  #15   0x000021afcf9c1d4e in x86::X86::do_init(x86::X86*) ../../src/device=
s/board/drivers/x86/x86.cc:60 <platform-bus-x86.so>+0x281d4e
  #16   0x000021afcf9e33ad in =CE=BB(x86::X86::ddk_init::(anon class)*) ../=
=2E./src/devices/board/drivers/x86/x86.cc:77 <platform-bus-x86.so>+0x2a33ad
  #17   0x000021afcf9e313e in fit::internal::target<(lambda at../../src/dev=
ices/board/drivers/x86/x86.cc:76:19), false, false, std::__2::allocator<std=
::byte>, void>::invoke(void*) ../../sdk/lib/fit/include/lib/fit/internal/fu=
nction.h:183 <platform-bus-x86.so>+0x2a313e
  #18   0x000021afcfbab4c7 in fit::internal::function_base<16UL, false, voi=
d(), std::__2::allocator<std::byte>>::invoke(const fit::internal::function_=
base<16UL, false, void (), std::__2::allocator<std::byte> >*) ../../sdk/lib=
/fit/include/lib/fit/internal/function.h:522 <platform-bus-x86.so>+0x46b4c7
  #19   0x000021afcfbab342 in fit::function_impl<16UL, false, void(), std::=
__2::allocator<std::byte>>::operator()(const fit::function_impl<16UL, false=
, void (), std::__2::allocator<std::byte> >*) ../../sdk/lib/fit/include/lib=
/fit/function.h:315 <platform-bus-x86.so>+0x46b342
  #20   0x000021afcfcd98c3 in async::internal::retained_task::Handler(async=
_dispatcher_t*, async_task_t*, zx_status_t) ../../sdk/lib/async/task.cc:24 =
<platform-bus-x86.so>+0x5998c3
  #21   0x00002290f9924616 in =CE=BB(const driver_runtime::Dispatcher::post=
_task::(anon class)*, std::__2::unique_ptr<driver_runtime::callback_request=
, std::__2::default_delete<driver_runtime::callback_request> >, zx_status_t=
) ../../src/devices/bin/driver_runtime/dispatcher.cc:789 <libdriver_runtime=
=2Eso>+0x10a616
  #22   0x00002290f9924323 in fit::internal::target<(lambda at../../src/dev=
ices/bin/driver_runtime/dispatcher.cc:788:7), true, false, std::__2::alloca=
tor<std::byte>, void, std::__2::unique_ptr<driver_runtime::callback_request=
, std::__2::default_delete<driver_runtime::callback_request>>, int>::invoke=
(void*, std::__2::unique_ptr<driver_runtime::callback_request, std::__2::de=
fault_delete<driver_runtime::callback_request> >, int) ../../sdk/lib/fit/in=
clude/lib/fit/internal/function.h:128 <libdriver_runtime.so>+0x10a323
  #23   0x00002290f9904b76 in fit::internal::function_base<24UL, true, void=
(std::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_d=
elete<driver_runtime::callback_request>>, int), std::__2::allocator<std::by=
te>>::invoke(const fit::internal::function_base<24UL, true, void (std::__2:=
:unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driv=
er_runtime::callback_request> >, int), std::__2::allocator<std::byte> >*, s=
td::__2::unique_ptr<driver_runtime::callback_request, std::__2::default_del=
ete<driver_runtime::callback_request> >, int) ../../sdk/lib/fit/include/lib=
/fit/internal/function.h:522 <libdriver_runtime.so>+0xeab76
  #24   0x00002290f9904831 in fit::callback_impl<24UL, true, void(std::__2:=
:unique_ptr<driver_runtime::callback_request, std::__2::default_delete<driv=
er_runtime::callback_request>>, int), std::__2::allocator<std::byte>>::oper=
ator()(fit::callback_impl<24UL, true, void (std::__2::unique_ptr<driver_run=
time::callback_request, std::__2::default_delete<driver_runtime::callback_r=
equest> >, int), std::__2::allocator<std::byte> >*, std::__2::unique_ptr<dr=
iver_runtime::callback_request, std::__2::default_delete<driver_runtime::ca=
llback_request> >, int) ../../sdk/lib/fit/include/lib/fit/function.h:471 <l=
ibdriver_runtime.so>+0xea831
  #25   0x00002290f98d5adc in driver_runtime::callback_request::Call(driver=
_runtime::callback_request*, std::__2::unique_ptr<driver_runtime::callback_=
request, std::__2::default_delete<driver_runtime::callback_request> >, zx_s=
tatus_t) ../../src/devices/bin/driver_runtime/callback_request.h:74 <libdri=
ver_runtime.so>+0xbbadc
  #26   0x00002290f98e1e58 in driver_runtime::Dispatcher::dispatch_callback=
(driver_runtime::Dispatcher*, std::__2::unique_ptr<driver_runtime::callback=
_request, std::__2::default_delete<driver_runtime::callback_request> >) ../=
=2E./src/devices/bin/driver_runtime/dispatcher.cc:1248 <libdriver_runtime.s=
o>+0xc7e58
  #27   0x00002290f98e4159 in driver_runtime::Dispatcher::dispatch_callback=
s(driver_runtime::Dispatcher*, std::__2::unique_ptr<driver_runtime::Dispatc=
her::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::eve=
nt_waiter> >, fbl::ref_ptr<driver_runtime::Dispatcher>) ../../src/devices/b=
in/driver_runtime/dispatcher.cc:1308 <libdriver_runtime.so>+0xca159
  #28   0x00002290f9918414 in =CE=BB(const driver_runtime::Dispatcher::crea=
te_with_adder::(anon class)*, std::__2::unique_ptr<driver_runtime::Dispatch=
er::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::even=
t_waiter> >, fbl::ref_ptr<driver_runtime::Dispatcher>) ../../src/devices/bi=
n/driver_runtime/dispatcher.cc:353 <libdriver_runtime.so>+0xfe414
  #29   0x00002290f991812d in fit::internal::target<(lambda at../../src/dev=
ices/bin/driver_runtime/dispatcher.cc:351:7), true, false, std::__2::alloca=
tor<std::byte>, void, std::__2::unique_ptr<driver_runtime::Dispatcher::even=
t_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_waiter=
>>, fbl::ref_ptr<driver_runtime::Dispatcher>>::invoke(void*, std::__2::uniq=
ue_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<d=
river_runtime::Dispatcher::event_waiter> >, fbl::ref_ptr<driver_runtime::Di=
spatcher>) ../../sdk/lib/fit/include/lib/fit/internal/function.h:128 <libdr=
iver_runtime.so>+0xfe12d
  #30   0x00002290f9906fc7 in fit::internal::function_base<8UL, true, void(=
std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::de=
fault_delete<driver_runtime::Dispatcher::event_waiter>>, fbl::ref_ptr<drive=
r_runtime::Dispatcher>), std::__2::allocator<std::byte>>::invoke(const fit:=
:internal::function_base<8UL, true, void (std::__2::unique_ptr<driver_runti=
me::Dispatcher::event_waiter, std::__2::default_delete<driver_runtime::Disp=
atcher::event_waiter> >, fbl::ref_ptr<driver_runtime::Dispatcher>), std::__=
2::allocator<std::byte> >*, std::__2::unique_ptr<driver_runtime::Dispatcher=
::event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_=
waiter> >, fbl::ref_ptr<driver_runtime::Dispatcher>) ../../sdk/lib/fit/incl=
ude/lib/fit/internal/function.h:522 <libdriver_runtime.so>+0xecfc7
  #31   0x00002290f9906c66 in fit::function_impl<8UL, true, void(std::__2::=
unique_ptr<driver_runtime::Dispatcher::event_waiter, std::__2::default_dele=
te<driver_runtime::Dispatcher::event_waiter>>, fbl::ref_ptr<driver_runtime:=
:Dispatcher>), std::__2::allocator<std::byte>>::operator()(const fit::funct=
ion_impl<8UL, true, void (std::__2::unique_ptr<driver_runtime::Dispatcher::=
event_waiter, std::__2::default_delete<driver_runtime::Dispatcher::event_wa=
iter> >, fbl::ref_ptr<driver_runtime::Dispatcher>), std::__2::allocator<std=
::byte> >*, std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, =
std::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, fbl::=
ref_ptr<driver_runtime::Dispatcher>) ../../sdk/lib/fit/include/lib/fit/func=
tion.h:315 <libdriver_runtime.so>+0xecc66
  #32   0x00002290f98e73d9 in driver_runtime::Dispatcher::event_waiter::inv=
oke_callback(driver_runtime::Dispatcher::event_waiter*, std::__2::unique_pt=
r<driver_runtime::Dispatcher::event_waiter, std::__2::default_delete<driver=
_runtime::Dispatcher::event_waiter> >, fbl::ref_ptr<driver_runtime::Dispatc=
her>) ../../src/devices/bin/driver_runtime/dispatcher.h:543 <libdriver_runt=
ime.so>+0xcd3d9
  #33   0x00002290f98e700d in driver_runtime::Dispatcher::event_waiter::han=
dle_event(std::__2::unique_ptr<driver_runtime::Dispatcher::event_waiter, st=
d::__2::default_delete<driver_runtime::Dispatcher::event_waiter> >, async_d=
ispatcher_t*, async::wait_base*, zx_status_t, zx_packet_signal_t const*) ..=
/../src/devices/bin/driver_runtime/dispatcher.cc:1442 <libdriver_runtime.so=
>+0xcd00d
  #34   0x00002290f9918983 in async_loop_owned_event_handler<driver_runtime=
::Dispatcher::event_waiter>::handle_event(async_loop_owned_event_handler<dr=
iver_runtime::Dispatcher::event_waiter>*, async_dispatcher_t*, async::wait_=
base*, zx_status_t, zx_packet_signal_t const*) ../../src/devices/bin/driver=
_runtime/async_loop_owned_event_handler.h:59 <libdriver_runtime.so>+0xfe983
  #35   0x00002290f9918b9e in async::wait_method<async_loop_owned_event_han=
dler<driver_runtime::Dispatcher::event_waiter>, &async_loop_owned_event_han=
dler<driver_runtime::Dispatcher::event_waiter>::handle_event>::call_handler=
(async_dispatcher_t*, async_wait_t*, zx_status_t, zx_packet_signal_t const*=
) ../../sdk/lib/async/include/lib/async/cpp/wait.h:201 <libdriver_runtime.s=
o>+0xfeb9e
  #36   0x00002290f99bf509 in async_loop_dispatch_wait(async_loop_t*, async=
_wait_t*, zx_status_t, zx_packet_signal_t const*) ../../sdk/lib/async-loop/=
loop.c:394 <libdriver_runtime.so>+0x1a5509
  #37   0x00002290f99b9958 in async_loop_run_once(async_loop_t*, zx_time_t)=
 ../../sdk/lib/async-loop/loop.c:343 <libdriver_runtime.so>+0x19f958
  #38   0x00002290f99b9247 in async_loop_run(async_loop_t*, zx_time_t, _Boo=
l) ../../sdk/lib/async-loop/loop.c:301 <libdriver_runtime.so>+0x19f247
  #39   0x00002290f99ba962 in async_loop_run_thread(void*) ../../sdk/lib/as=
ync-loop/loop.c:860 <libdriver_runtime.so>+0x1a0962
  #40   0x000041afd176ef30 in start_c11(void*) ../../zircon/third_party/uli=
b/musl/pthread/pthread_create.c:63 <libc.so>+0x84f30
  #41   0x000041afd18a448d in thread_trampoline(uintptr_t, uintptr_t) ../..=
/zircon/system/ulib/runtime/thread.cc:100 <libc.so>+0x1ba48d

Link: https://github.com/acpica/acpica/commit/1c28da22
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
=2D--
 drivers/acpi/acpica/amlresrc.h |  8 ++++----
 drivers/acpi/acpica/rsaddr.c   | 13 ++++---------
 drivers/acpi/acpica/rscalc.c   | 22 +++++-----------------
 drivers/acpi/acpica/rslist.c   | 12 +++---------
 drivers/acpi/acpica/utresrc.c  | 14 +++++---------
 5 files changed, 21 insertions(+), 48 deletions(-)

diff --git a/drivers/acpi/acpica/amlresrc.h b/drivers/acpi/acpica/amlresrc.h
index 4e88f9fc2a28..b6588b7fa898 100644
=2D-- a/drivers/acpi/acpica/amlresrc.h
+++ b/drivers/acpi/acpica/amlresrc.h
@@ -504,10 +504,6 @@ struct aml_resource_pin_group_config {
=20
 #define AML_RESOURCE_PIN_GROUP_CONFIG_REVISION    1	/* ACPI 6.2 */
=20
=2D/* restore default alignment */
=2D
=2D#pragma pack()
=2D
 /* Union of all resource descriptors, so we can allocate the worst case */
=20
 union aml_resource {
@@ -562,6 +558,10 @@ union aml_resource {
 	u8 byte_item;
 };
=20
+/* restore default alignment */
+
+#pragma pack()
+
 /* Interfaces used by both the disassembler and compiler */
=20
 void
diff --git a/drivers/acpi/acpica/rsaddr.c b/drivers/acpi/acpica/rsaddr.c
index 27384ee245f0..f92010e667cd 100644
=2D-- a/drivers/acpi/acpica/rsaddr.c
+++ b/drivers/acpi/acpica/rsaddr.c
@@ -272,18 +272,13 @@ u8
 acpi_rs_get_address_common(struct acpi_resource *resource,
 			   union aml_resource *aml)
 {
=2D	struct aml_resource_address address;
=2D
 	ACPI_FUNCTION_ENTRY();
=20
=2D	/* Avoid undefined behavior: member access within misaligned address */
=2D
=2D	memcpy(&address, aml, sizeof(address));
=2D
 	/* Validate the Resource Type */
=20
=2D	if ((address.resource_type > 2) &&
=2D	    (address.resource_type < 0xC0) && (address.resource_type !=3D 0x0A)=
) {
+	if ((aml->address.resource_type > 2) &&
+	    (aml->address.resource_type < 0xC0) &&
+	    (aml->address.resource_type !=3D 0x0A)) {
 		return (FALSE);
 	}
=20
@@ -304,7 +299,7 @@ acpi_rs_get_address_common(struct acpi_resource *resour=
ce,
 		/* Generic resource type, just grab the type_specific byte */
=20
 		resource->data.address.info.type_specific =3D
=2D		    address.specific_flags;
+		    aml->address.specific_flags;
 	}
=20
 	return (TRUE);
diff --git a/drivers/acpi/acpica/rscalc.c b/drivers/acpi/acpica/rscalc.c
index 6e7a152d6459..242daf45e20e 100644
=2D-- a/drivers/acpi/acpica/rscalc.c
+++ b/drivers/acpi/acpica/rscalc.c
@@ -608,18 +608,12 @@ acpi_rs_get_list_length(u8 *aml_buffer,
=20
 		case ACPI_RESOURCE_NAME_SERIAL_BUS:{
=20
=2D				/* Avoid undefined behavior: member access within misaligned address=
 */
=2D
=2D				struct aml_resource_common_serialbus
=2D				    common_serial_bus;
=2D				memcpy(&common_serial_bus, aml_resource,
=2D				       sizeof(common_serial_bus));
=2D
 				minimum_aml_resource_length =3D
 				    acpi_gbl_resource_aml_serial_bus_sizes
=2D				    [common_serial_bus.type];
+				    [aml_resource->common_serial_bus.type];
 				extra_struct_bytes +=3D
=2D				    common_serial_bus.resource_length -
+				    aml_resource->common_serial_bus.
+				    resource_length -
 				    minimum_aml_resource_length;
 				break;
 			}
@@ -688,16 +682,10 @@ acpi_rs_get_list_length(u8 *aml_buffer,
 		 */
 		if (acpi_ut_get_resource_type(aml_buffer) =3D=3D
 		    ACPI_RESOURCE_NAME_SERIAL_BUS) {
=2D
=2D			/* Avoid undefined behavior: member access within misaligned address =
*/
=2D
=2D			struct aml_resource_common_serialbus common_serial_bus;
=2D			memcpy(&common_serial_bus, aml_resource,
=2D			       sizeof(common_serial_bus));
=2D
 			buffer_size =3D
 			    acpi_gbl_resource_struct_serial_bus_sizes
=2D			    [common_serial_bus.type] + extra_struct_bytes;
+			    [aml_resource->common_serial_bus.type] +
+			    extra_struct_bytes;
 		} else {
 			buffer_size =3D
 			    acpi_gbl_resource_struct_sizes[resource_index] +
diff --git a/drivers/acpi/acpica/rslist.c b/drivers/acpi/acpica/rslist.c
index 164c96e063c6..e46efaa889cd 100644
=2D-- a/drivers/acpi/acpica/rslist.c
+++ b/drivers/acpi/acpica/rslist.c
@@ -55,21 +55,15 @@ acpi_rs_convert_aml_to_resources(u8 * aml,
 	aml_resource =3D ACPI_CAST_PTR(union aml_resource, aml);
=20
 	if (acpi_ut_get_resource_type(aml) =3D=3D ACPI_RESOURCE_NAME_SERIAL_BUS) {
=2D
=2D		/* Avoid undefined behavior: member access within misaligned address */
=2D
=2D		struct aml_resource_common_serialbus common_serial_bus;
=2D		memcpy(&common_serial_bus, aml_resource,
=2D		       sizeof(common_serial_bus));
=2D
=2D		if (common_serial_bus.type > AML_RESOURCE_MAX_SERIALBUSTYPE) {
+		if (aml_resource->common_serial_bus.type >
+		    AML_RESOURCE_MAX_SERIALBUSTYPE) {
 			conversion_table =3D NULL;
 		} else {
 			/* This is an I2C, SPI, UART, or CSI2 serial_bus descriptor */
=20
 			conversion_table =3D
 			    acpi_gbl_convert_resource_serial_bus_dispatch
=2D			    [common_serial_bus.type];
+			    [aml_resource->common_serial_bus.type];
 		}
 	} else {
 		conversion_table =3D
diff --git a/drivers/acpi/acpica/utresrc.c b/drivers/acpi/acpica/utresrc.c
index cff7901f7866..e1cc3d348750 100644
=2D-- a/drivers/acpi/acpica/utresrc.c
+++ b/drivers/acpi/acpica/utresrc.c
@@ -361,20 +361,16 @@ acpi_ut_validate_resource(struct acpi_walk_state *wal=
k_state,
 	aml_resource =3D ACPI_CAST_PTR(union aml_resource, aml);
 	if (resource_type =3D=3D ACPI_RESOURCE_NAME_SERIAL_BUS) {
=20
=2D		/* Avoid undefined behavior: member access within misaligned address */
=2D
=2D		struct aml_resource_common_serialbus common_serial_bus;
=2D		memcpy(&common_serial_bus, aml_resource,
=2D		       sizeof(common_serial_bus));
=2D
 		/* Validate the bus_type field */
=20
=2D		if ((common_serial_bus.type =3D=3D 0) ||
=2D		    (common_serial_bus.type > AML_RESOURCE_MAX_SERIALBUSTYPE)) {
+		if ((aml_resource->common_serial_bus.type =3D=3D 0) ||
+		    (aml_resource->common_serial_bus.type >
+		     AML_RESOURCE_MAX_SERIALBUSTYPE)) {
 			if (walk_state) {
 				ACPI_ERROR((AE_INFO,
 					    "Invalid/unsupported SerialBus resource descriptor: BusType 0x%2.=
2X",
=2D					    common_serial_bus.type));
+					    aml_resource->common_serial_bus.
+					    type));
 			}
 			return (AE_AML_INVALID_RESOURCE_TYPE);
 		}
=2D-=20
2.43.0





