Return-Path: <linux-acpi+bounces-1399-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1397E7958
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Nov 2023 07:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80173280FC2
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Nov 2023 06:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37802746F
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Nov 2023 06:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=owenh.net header.i=@owenh.net header.b="qoHS2aXx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDD85693
	for <linux-acpi@vger.kernel.org>; Fri, 10 Nov 2023 06:22:30 +0000 (UTC)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B72E6E9D;
	Thu,  9 Nov 2023 22:22:29 -0800 (PST)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4SRQ2S0zBvz9scN;
	Fri, 10 Nov 2023 04:55:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=owenh.net; s=MBO0001;
	t=1699588512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+mYWcVAli9GCc4vPf2eDB3X2wHHEc2PFC+6KilCNEcA=;
	b=qoHS2aXxsUcpqJPKJdC4SI2fQWD6CvHKZd8rgtalJQ45BHmCBDsStfHNnHSu8PLqXeZKPX
	3Wj+RmMzerw3iIO1vcSWmri07ckQ8LlA2IsEPbkkFSS4j4yyREWIxIyNfM5owqOUvmw8wJ
	ycE8DKReVnsEcY/xBRqXHcDXOhshiUQJ3TGfWyzO8ihjGhcDpqLspeX5r53oHdDnjuzj7T
	/kxYjemXrPEERerMX25HLj/Ck8uBBcRsq6f6cHz0vCCWsqVaHEcw/ZImjw+VKs1ENVMoAq
	ykVk2v699lp4qBjo/vfan+boUAgxQO/dtXDSjnYlq2jYjZ3UxYlckAVe2HMM9Q==
Message-ID: <9f36fb06-64c4-4264-aaeb-4e1289e764c4@owenh.net>
Date: Thu, 9 Nov 2023 21:55:01 -0600
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
To: stable@vger.kernel.org
Cc: regressions@lists.linux.dev, Kai-Heng Feng <kai.heng.feng@canonical.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown
 <lenb@kernel.org>, linux-acpi@vger.kernel.org,
 Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@redhat.com>, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org
From: "Owen T. Heisler" <writer@owenh.net>
Subject: [REGRESSION]: acpi/nouveau: Hardware unavailable upon resume or
 suspend fails
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4SRQ2S0zBvz9scN

#regzbot introduced: 89c290ea758911e660878e26270e084d862c03b0
#regzbot link: https://gitlab.freedesktop.org/drm/nouveau/-/issues/273
#regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=218124

## Reproducing

1. Boot system to framebuffer console.
2. Run `systemctl suspend`. If undocked without secondary display, 
suspend fails. If docked with secondary display, suspend succeeds.
3. Resume from suspend if applicable.
4. System is now in a broken state.

## Testing

- culprit commit is 89c290ea758911e660878e26270e084d862c03b0
- v6.6 fails
- v6.6 with culprit commit reverted does not fail
- Compiled with 
<https://gitlab.freedesktop.org/drm/nouveau/uploads/788d7faf22ba2884dcc09d7be931e813/v6.6-config1>

## Hardware

- ThinkPad W530 2438-52U
- Dock with Nvidia-connected DVI ports
- Secondary display connected via DVI
- Nvidia Optimus GPU switching system

```console
$ lspci | grep -i vga
00:02.0 VGA compatible controller: Intel Corporation 3rd Gen Core 
processor Graphics Controller (rev 09)
01:00.0 VGA compatible controller: NVIDIA Corporation GK107GLM [Quadro 
K2000M] (rev a1)
```

## Decoded logs from v6.6

- System is not docked and fails to suspend: 
<https://gitlab.freedesktop.org/drm/nouveau/uploads/fb8fdf5a6bed1b1491d2544ab67fa257/undocked.log>
- System is docked and fails after resume: 
<https://gitlab.freedesktop.org/drm/nouveau/uploads/cb3d5ac55c01f663cd80fa000cd6a3b5/docked.log>

