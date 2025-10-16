Return-Path: <linux-acpi+bounces-17810-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA88FBE37A9
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Oct 2025 14:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAE39583AE5
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Oct 2025 12:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B07332D7E4;
	Thu, 16 Oct 2025 12:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="1jgQmlEP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0183A2E0B68
	for <linux-acpi@vger.kernel.org>; Thu, 16 Oct 2025 12:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760618882; cv=none; b=V/1IceWEMmS7o+rtVc+szbkTJ+h0KX4eQnQEg4bbtnoGE0DI6S8AXpqGMyfGKUMUlVFv6DYOq+jO4PACLyBh0+uciy8m2A8R80/AT4hDXaIukwcJ3qWhnwDo+O7vNO97TweJlO0PbDgCL7D2fBAN/l0LsN+60fqtEw/Ux4qjcOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760618882; c=relaxed/simple;
	bh=2VGYIFhCEbg4Av7ThEIru62x0BzDYBfbXS+3ApUDDF4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=GZBdmnbbLn/asRtWOoyK0FQG8Ag4nBxLXrezXx3tMmVUk9/xjZ2nU+KCt++BoT4UA9C4BqYRwOAnkjWn/l335bJ2vgjlsAvrG41JUQDEmEjpYwUMijjrsf+tgPZ+AjD3V0/TOXnFFSl2zhD5//WOeo2iRE1eI+PcFv+uZoyM7h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=1jgQmlEP; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 0C0801A1428
	for <linux-acpi@vger.kernel.org>; Thu, 16 Oct 2025 12:47:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D38F36062C;
	Thu, 16 Oct 2025 12:47:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CE650102F22EF;
	Thu, 16 Oct 2025 14:47:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760618874; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language;
	bh=bDlImIPnSemLL+2SLF2wFv7SSzHssDb0btu+nU/rJmU=;
	b=1jgQmlEPos1PB5Fh62MniFagobrgwHnxZS+CfVr/57V9xJEvZoIgBCyh1d1P7947xJeXlG
	YHcNYBgBcnzE+cIZurnvR/SbogHePnEq0DaRVyTjc8m/ss8BYw5sd79ylaAfyCo6mXyjnv
	FgKjoFxfKVRDvGrp63upRa/jBNhAyxA1TejJMcdxV5zkwe9uSELiRUM8IcBgmDYWI8rvhl
	n2C8HMT91RfwJ0njDQh+xYbiQ5s1yp6J9yQrwD3nevQnW6N+PxvOXxe1cCaNukvzqACSfw
	IDQHsEUuSoK+turinZkaXxTg3C+IkLOOb4gRtuFaug9cOjwCkbCWk7Udp0V7iw==
Message-ID: <c321423b-3cdb-41a5-9939-dc5c846cfcd4@bootlin.com>
Date: Thu, 16 Oct 2025 14:47:40 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Thomas Richard <thomas.richard@bootlin.com>
Subject: [REGRESSION] in 6.18-rc1, failed to query a GPIO using a name in ACPI
To: rafael@kernel.org
Cc: regressions@lists.linux.dev, lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 sunilvl@ventanamicro.com, apatel@ventanamicro.com,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Daniele Cleri <DanieleCleri@aaeon.eu>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hello,

While testing the AAEON UpBoard MFD driver with the v6.18-rc1 release, I
noticed a regression. The driver does not probe anymore and I get the
following error:

[    1.977831] upboard-fpga AANT0F01:00: error -ENOENT: Failed to
initialize FPGA common GPIOs
[    1.977854] upboard-fpga AANT0F01:00: probe with driver upboard-fpga
failed with error -2

The driver fails to get some GPIOs using a name [1] in the ACPI tables [2].

I did a bisect and I found the commit which introduced the regression:
e121be784d35 ("ACPI: property: Refactor acpi_fwnode_get_reference_args()
to support nargs_prop")

Best Regards,

Thomas

[1]
https://elixir.bootlin.com/linux/v6.17/source/drivers/mfd/upboard-fpga.c#L192
[2] https://gist.github.com/thom24/2da44ef86eacfa5d2d492ce43fa41aa4


