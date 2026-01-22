Return-Path: <linux-acpi+bounces-20499-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IwCNxfUcWk+MgAAu9opvQ
	(envelope-from <linux-acpi+bounces-20499-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 08:39:03 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BEEC62958
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 08:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 576BE7202D1
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 07:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89CEC481237;
	Thu, 22 Jan 2026 07:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=picoheart-com.20200927.dkim.feishu.cn header.i=@picoheart-com.20200927.dkim.feishu.cn header.b="yPkUDbBQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from sg-1-38.ptr.blmpb.com (sg-1-38.ptr.blmpb.com [118.26.132.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA47314B64
	for <linux-acpi@vger.kernel.org>; Thu, 22 Jan 2026 07:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769067311; cv=none; b=WYs1gGRtQog9xUtF3PdmiTp/NKZu+iYljKXWJtleZA2+l2DuIy+Tay9Cs9fgAR1ZsPIWTbnvFrMK1Cwnd883pMDdBeFhsKeyrwbIq88NVxdZwvGhBcmNSVci0ubEP9LUM0o8zPkaap/EdOfD9Wa3WYRKnAAD/EqLqoQnp9Re/Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769067311; c=relaxed/simple;
	bh=ShsQ3XBv7vrfIszF1XeNH9xjI9L7Tvs722lbbOYnkHU=;
	h=To:Date:Cc:Mime-Version:From:Subject:Message-Id:Content-Type; b=VE8umo621dfDnqNgE9Io/orgODJGFOAONWE45ZcMBAnZXBgDMlxJk574wulShquMvhVMj4PctyTDFUNO9f7YJsa2b8/tnb+QV5uFjTZoukYKf20pQiHIMmnEXWwdvnb8Ugw+ST/sv5mUlDcBuZO+qYQQVetnxz0PPHdWIeWaXzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=picoheart.com; spf=pass smtp.mailfrom=picoheart.com; dkim=pass (2048-bit key) header.d=picoheart-com.20200927.dkim.feishu.cn header.i=@picoheart-com.20200927.dkim.feishu.cn header.b=yPkUDbBQ; arc=none smtp.client-ip=118.26.132.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=picoheart.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=picoheart.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=picoheart-com.20200927.dkim.feishu.cn; t=1769067292;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=4/OBCIJE/VhfTNxo9r56MT8A/UZqxjI8m594zPId+d8=;
 b=yPkUDbBQmg4A5gG4g1Of+/pcuhKu2t2xyKH8lNWoVZ/A+Au/1y9PRwTShSejjxOc9pplcN
 FX+sPlvEBQs6vig+93B4mv04gXRo5TWm7dBX0cKGmyi5mJ+IqMlbEUA00Jxne+DrEDMPLu
 L4PvRfcJf2L8x0olq0XxKASVV5qJ+35H29hs/+hl04GBY2IgOfXkv026T6XcwgqvNnuXM1
 t/jugebA4yIF6PSlZYwU7DySJIYYNklVYKfkCmfUBcs0cEd1hISacz5cBcy4yCW+EBszKc
 szYgHVybpemNu1FunMucN3wQTvhNg6V9pmnGrnSy32FV4aGNiktDGef+xHVVbw==
To: <rafael@kernel.org>, <lenb@kernel.org>, <tglx@kernel.org>, 
	<gregkh@linuxfoundation.org>, <dakr@kernel.org>
Date: Thu, 22 Jan 2026 15:34:44 +0800
X-Original-From: Yicong Yang <yang.yicong@picoheart.com>
Cc: <akpm@linux-foundation.org>, <apatel@ventanamicro.com>, <pjw@kernel.org>, 
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>, 
	<geshijian@picoheart.com>, <weidong.wd@picoheart.com>, 
	<yang.yicong@picoheart.com>, <linux-acpi@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
From: "Yicong Yang" <yang.yicong@picoheart.com>
Subject: [PATCH 0/2] Ensure some device initialization before init task
Received: from G9WYR9K0VW ([58.250.122.114]) by smtp.feishu.cn with ESMTPS; Thu, 22 Jan 2026 15:34:49 +0800
X-Mailer: git-send-email 2.50.1
X-Lms-Return-Path: <lba+26971d31a+e8227d+vger.kernel.org+yang.yicong@picoheart.com>
Message-Id: <20260122073446.45628-1-yang.yicong@picoheart.com>
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[picoheart-com.20200927.dkim.feishu.cn:s=s1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20499-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[picoheart.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yang.yicong@picoheart.com,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[picoheart-com.20200927.dkim.feishu.cn:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-acpi];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,picoheart-com.20200927.dkim.feishu.cn:dkim]
X-Rspamd-Queue-Id: 5BEEC62958
X-Rspamd-Action: no action

Fix two issues that may cause devices initialization finished
after entering init task.

Patch 1 ensure the device object scanning by acpi_scan_clear_dep_fn()
is finished before entering init task. Otherwise if some key devices
like console or root device are not ready when entering init task,
the system will panic (no available console) or enter rescure shell
(no root device). It's more possible on RISCV since these devices
are scan and created by acpi_scan_clear_dep_fn() and we've observed
this.

Patch 2 fix a theoretical issue that the console initialization is
still in process by the time we open the console. Since we call
console_on_rootfs() before async_synchronize_full(), there's no
guaranteed for the order.

Thanks Thomas for the discussion to debug these two issues [1].

[1] https://lore.kernel.org/linux-riscv/20260114063730.78009-1-yang.yicong@picoheart.com/

Yicong Yang (2):
  ACPI: scan: Use async schedule function for acpi_scan_clear_dep_fn
  init: Move console_on_rootfs after async_synchronize_full

 drivers/acpi/scan.c | 35 ++++++++++++++++-------------------
 init/main.c         |  4 ++--
 2 files changed, 18 insertions(+), 21 deletions(-)

-- 
2.34.1

