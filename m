Return-Path: <linux-acpi+bounces-3730-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDDB85C46D
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Feb 2024 20:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEB4D1C23240
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Feb 2024 19:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C642A76C9C;
	Tue, 20 Feb 2024 19:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="W98vNYuk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from silver.cherry.relay.mailchannels.net (silver.cherry.relay.mailchannels.net [23.83.223.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFB16A8D0;
	Tue, 20 Feb 2024 19:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708456452; cv=pass; b=JFB/v15t57FDATenl4kiT4btN9GPEMylIcRNEfqxoQW2BCazZ+JsMlYgKiQLhZf5qm/n/urOCVaIqpa/RFxU4VbrG9L6gTm7wUFKTOc5Q0i3GXERkVtLMraAVBTUB++m/X2pw4HjcGgbPjlBpxRmUE2QEy0emanwj2hANct46dA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708456452; c=relaxed/simple;
	bh=QqYTsdgfkGaA0+2WLmEq5KxQ3DqtKT2MQ0tXYpIwWm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ft+HNkkW2NnKN+hBvoYmzNjIn8DLtkXcvo2Swch+oCVe9xbAwoWG+taMOhYST+2n+tkJUH9Z6GC1NzlYXy9MQX/URPTBDb0nVwg+hnHzEF3uvDkn7wLqYKb1hsrzmzWjPWy4didnCQc+IsR9GLEb4W5zHAbyNQWSpWrefS5f3EA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=W98vNYuk; arc=pass smtp.client-ip=23.83.223.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 54A034C33E5;
	Tue, 20 Feb 2024 19:02:24 +0000 (UTC)
Received: from pdx1-sub0-mail-a209.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id ADD844C3851;
	Tue, 20 Feb 2024 19:02:23 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1708455743; a=rsa-sha256;
	cv=none;
	b=WV7+3ZS4xEDkj9HeItHwkBKU1P6hTGEvr7BR6lxL8MAw2SwMU+XDCaQlZqOCVmRF0qynuL
	YAuw0CoUED1pJ32/KXS+oIK7XiNX41mFaQ2uN16bbXiLU3WEzZU1scxlxgfCpw57rlRY1J
	NbUMGHqx3VcXuysSpp0jh7yOGTDQlKV6/TWpEid940YOOirmAV3GCy9wp17BeldlHdloZe
	bOtk9JFE4d1PunyfQrDAweNUsKkZ4AWwrmrNomYdCNDnoDqqjp1n/6SyiNrrI3Qd4W/8qN
	TK+DieT1Tynry9DsbCc7Z5vKP5UOelsgBniox3Tws1PNuocOKEOWlKLlfrH17g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1708455743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=dNoqc0ROEmDCWv3V5jBsk4/xRfF3wcx6GQTPxOSluMU=;
	b=Yx8nYuB120IG0g3a/cHnBsPUYdJB7Oxt0/X9buigI6wHMiwSL2gCQYpNOiiJQVAPi2y0vF
	hyF1E2FOm/GA2bznKqfUCxcT/hzgivCbvAMZoTRgiT4QBja5tvCoGUJp6bOvrlLMN4iGF1
	hvzT1OWl9ipVezxwMyNORvAKLd6s8osMrg6+mECTbgSDyXWcOoQksd347waJ5066OrXREb
	+96ZDH7LyEI+LtNvVDq19Pd1Tev7Er+LYi1JsBt48Jkpn9nbisWc6OmIsVR5YVIbLZCPdS
	5RGPge9hW/c/kr4MtiwhZ5SbWhYvSWaxitvyY23fI7+5sMehiPM4Yj+sVXrqlg==
ARC-Authentication-Results: i=1;
	rspamd-55b4bfd7cb-j8w5d;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Trade-Chemical: 5e7984800d80b752_1708455744127_3524070432
X-MC-Loop-Signature: 1708455744127:3356217050
X-MC-Ingress-Time: 1708455744127
Received: from pdx1-sub0-mail-a209.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.113.222.102 (trex/6.9.2);
	Tue, 20 Feb 2024 19:02:24 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a209.dreamhost.com (Postfix) with ESMTPSA id 4TfTL65FYYzK2;
	Tue, 20 Feb 2024 11:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1708455743;
	bh=dNoqc0ROEmDCWv3V5jBsk4/xRfF3wcx6GQTPxOSluMU=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=W98vNYukpdBPO2QXCTBZlrH7vdA7RLYQ6Bimli66BSDdwyOKWJYEk7FQ9KQfIsIoJ
	 V1emfBKgmD9HLzowrggQ4ndNeOBXij+GSvclqHgJmGnPtTS0V5qflM6v8Jhsuwm2M7
	 hY9Oidf2sa/9DnToxReMyGYOuwT1mER47/S+PLnNLvyQu+NQdp6Amb/Y0/1Zll5M74
	 UtkmptVAPbWJoVr9ut4wLe7HLspCuIL2yNL/AeeYKNkoa8z0mhLytPlufFFXrjkFGj
	 PFUJNJFPGybjlgePc2QYqZUZqARdlQK9q0W8IIxMOkB89HJSoUS+4hW9eWLRRZ5Bau
	 4oajwz+tiHLMw==
Date: Tue, 20 Feb 2024 11:02:19 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>
Cc: dan.j.williams@intel.com, jonathan.cameron@huawei.com, 
	rafael@kernel.org, james.morse@arm.com, tony.luck@intel.com, bp@alien8.de, 
	dave@stogolabs.net, dave.jiang@intel.com, alison.schofield@intel.com, 
	vishal.l.verma@intel.com, ira.weiny@intel.com, linux-cxl@vger.kernel.org, 
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH v12 3/3] EINJ, Documentation: Update EINJ kernel doc
Message-ID: <l6mrrp7pvnl5arrluiqyekpejzlqftdjqt7b5c6sje7yziqnl6@s2mseu64lx4j>
References: <20240214200709.777166-1-Benjamin.Cheatham@amd.com>
 <20240214200709.777166-4-Benjamin.Cheatham@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240214200709.777166-4-Benjamin.Cheatham@amd.com>
User-Agent: NeoMutt/20231221

On Wed, 14 Feb 2024, Ben Cheatham wrote:

>Update EINJ kernel document to include how to inject CXL protocol error
>types, build the kernel to include CXL error types, and give an example
>injection.
>
>Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>

Would vote for folding into 2/3, but otherwise looks good with a minor
suggestion.

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

>---
> .../firmware-guide/acpi/apei/einj.rst         | 19 +++++++++++++++++++
> 1 file changed, 19 insertions(+)
>
>diff --git a/Documentation/firmware-guide/acpi/apei/einj.rst b/Documentation/firmware-guide/acpi/apei/einj.rst
>index d6b61d22f525..f179adf7b61c 100644
>--- a/Documentation/firmware-guide/acpi/apei/einj.rst
>+++ b/Documentation/firmware-guide/acpi/apei/einj.rst
>@@ -181,6 +181,25 @@ You should see something like this in dmesg::
>   [22715.834759] EDAC sbridge MC3: PROCESSOR 0:306e7 TIME 1422553404 SOCKET 0 APIC 0
>   [22716.616173] EDAC MC3: 1 CE memory read error on CPU_SrcID#0_Channel#0_DIMM#0 (channel:0 slot:0 page:0x12345 offset:0x0 grain:32 syndrome:0x0 -  area:DRAM err_code:0001:0090 socket:0 channel_mask:1 rank:0)
>
>+CXL error types are supported from ACPI 6.5 onwards. These error types
						     ^ and target a CXL Port

>+are not available in the legacy interface at /sys/kernel/debug/apei/einj,
>+and are instead at /sys/kernel/debug/cxl/. There is a file under debug/cxl
>+called "einj_type" that is analogous to available_error_type under debug/cxl.
>+There is also a "einj_inject" file in each $dport_dev directory under debug/cxl
>+that will inject a given error into the dport represented by $dport_dev.
>+For example, to inject a CXL.mem protocol correctable error into
>+$dport_dev=pci0000:0c::
>+
>+    # cd /sys/kernel/debug/cxl/
>+    # cat einj_type                 # See which error can be injected
>+	0x00008000  CXL.mem Protocol Correctable
>+	0x00010000  CXL.mem Protocol Uncorrectable non-fatal
>+	0x00020000  CXL.mem Protocol Uncorrectable fatal
>+    # cd 0000:e0:01.1               # Navigate to dport to inject into
>+    # echo 0x8000 > einj_inject     # Inject error
>+
>+To use CXL error types, ``CONFIG_CXL_EINJ`` will need to be enabled.
>+
> Special notes for injection into SGX enclaves:
>
> There may be a separate BIOS setup option to enable SGX injection.
>--
>2.34.1
>

