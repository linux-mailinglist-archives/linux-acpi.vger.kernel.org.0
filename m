Return-Path: <linux-acpi+bounces-4497-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 356CE88DB87
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Mar 2024 11:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 652FA1C268C6
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Mar 2024 10:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0046B38FA1;
	Wed, 27 Mar 2024 10:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="g5JEHzLd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from forward101c.mail.yandex.net (forward101c.mail.yandex.net [178.154.239.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06B02C180
	for <linux-acpi@vger.kernel.org>; Wed, 27 Mar 2024 10:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711536527; cv=none; b=ZB7fQzOuxPhCpb4AM7KZdXu73yAe0Or+BkDwMhMwvEKs81AzFEmMxXfs9OweK+BGGpQ4J+pfqrPu4DXYZ08VfO2A7xS608ubAUra30dWvVKVeGNCZMDrunT3M1A6IBAi6qhCdKeazI0SCsIw7W2m4jTCKtblVG5aBxgrSPnLoVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711536527; c=relaxed/simple;
	bh=cLuTmATVqniDZfvN/Fm7nWpy6tZE+44hMyxnr4HpV5o=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=rd4IP3lg7I/MaUIZ4KNi4uZlYdOOM64/jJbvO1wB7a6gA97PIkPRRR76YtF8Ol8hny7sSnA0jkbNfSpb2vxnISbn7r4NWr9HjlxP8/rn4Bx5URQrKVlZFELIhESNf+Q2WZiW83u0mPNPoe+knKXTwn5fG5b4POlVqti0k0y+ARE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=g5JEHzLd; arc=none smtp.client-ip=178.154.239.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-90.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-90.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:20ad:0:640:1465:0])
	by forward101c.mail.yandex.net (Yandex) with ESMTPS id 80A7860AB5;
	Wed, 27 Mar 2024 13:48:35 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-90.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id XmJp812Og8c0-QEdnrxGE;
	Wed, 27 Mar 2024 13:48:35 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1711536515; bh=3gdyxb1TvFgt00g2R5qnrrlAAVlR1PMiseWo/ml51zk=;
	h=Subject:From:Cc:To:Date:Message-ID;
	b=g5JEHzLdDEvU1QONYFqTmk36WVgPfM3AonuWwli6pfXcCJio6DIhj3+A3DXEAfEcR
	 3MThqx8p16zg98GLbtXOHMP9NO3gKhbZ1Kpt0k9nUcL3cUTAbZZ4Gk1zCHJXqWsZBC
	 feXdHIpoxgktGJa8lF2mrZO3+pQf5ZROFJnFT42w=
Authentication-Results: mail-nwsmtp-smtp-production-main-90.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <9d0a3bd8-62d6-43cc-8109-311448ad0867@yandex.ru>
Date: Wed, 27 Mar 2024 13:48:32 +0300
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-acpi@vger.kernel.org
From: Dmitry Antipov <dmantipov@yandex.ru>
Subject: ACPI BIOS bug and memory leak?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Is it possible that this:

[    7.727080] ACPI BIOS Error (bug): Could not resolve symbol [\_TZ.ETMD], AE_NOT_FOUND (20230628/psargs-335)
[    7.728470] ACPI Error: Aborting method \_SB.IETM._OSC due to previous error (AE_NOT_FOUND) (20230628/psparse-529)

is somehow related to:

unreferenced object 0xffff944e85013d58 (size 56):
   comm "thermald", pid 966, jiffies 4294674933
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 0d 01 2d 00 00 00 00 00  ..........-.....
     94 8c 05 80 51 b8 ff ff 00 00 00 00 00 00 00 00  ....Q...........
   backtrace (crc 41e9984d):
     [<000000004b53f9d1>] kmem_cache_alloc+0x256/0x340
     [<000000008d9ead3a>] acpi_ps_alloc_op+0xbf/0xd0
     [<000000002f1e617e>] acpi_ps_get_next_arg+0xbb/0x6a0
     [<00000000b697bac7>] acpi_ps_parse_loop+0x466/0x6b0
     [<000000008dbc2acb>] acpi_ps_parse_aml+0x80/0x3c0
     [<00000000b26066ae>] acpi_ps_execute_method+0x13f/0x270
     [<00000000f80592ab>] acpi_ns_evaluate+0x12b/0x2c0
     [<00000000bbc91886>] acpi_evaluate_object+0x14e/0x310
     [<000000005729c43d>] acpi_run_osc+0x158/0x270
     [<00000000e6666993>] int3400_thermal_run_osc+0x73/0xc0 [int3400_thermal]
     [<000000000a474314>] current_uuid_store+0xd5/0x110 [int3400_thermal]
     [<00000000e27be786>] kernfs_fop_write_iter+0x13e/0x1f0
     [<00000000992f9e08>] vfs_write+0x293/0x460
     [<000000008b9e130c>] ksys_write+0x6d/0xf0
     [<000000007d501d09>] do_syscall_64+0x85/0x170
     [<0000000073c5a34b>] entry_SYSCALL_64_after_hwframe+0x6c/0x74

(recently observed on 6.9.0-rc1)

Dmitry

