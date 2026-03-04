Return-Path: <linux-acpi+bounces-21345-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAS6Cq59qGmHuwAAu9opvQ
	(envelope-from <linux-acpi+bounces-21345-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 04 Mar 2026 19:45:02 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8681320690C
	for <lists+linux-acpi@lfdr.de>; Wed, 04 Mar 2026 19:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD74D3110C27
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Mar 2026 18:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36363D6CA2;
	Wed,  4 Mar 2026 18:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hE9wlb0+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804E03D6686;
	Wed,  4 Mar 2026 18:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772649218; cv=none; b=tUOD0UPHobHaJe/QubUz1vHbN4PFdTtuqFGNutdDHYfJtOIB3ALVBg8OlCu9PwYeXM9BQBe5vfcFP9c4g8hcxjX1FfgZJFoyoPyt9sO5/2DqrgH69wjRFdWcNCHAmhnVX1TdXZVfS9JbdtG9fbHTnru5qIMoF4dWn+cJjSiAiRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772649218; c=relaxed/simple;
	bh=RQdiDeOtHfF6Pal/tLUKly0TFJY4YYJCU3MQfoJSd30=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eFpTgLLTCN+K2vqb1G8SDx2evF4fi5skgP06/rYwaLuB8ZbY5eM4xNb80D7C0LSVCLz/FRx5PW+HWHW173avJq2iZz8otF9XRVZeLvLs9VeOONKOaCHJnQwSycAvKK2Mit2BszaLD8I4m2/qMjs0tgSHwQmkvOHnO03QiqVFYxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hE9wlb0+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 935DDC4CEF7;
	Wed,  4 Mar 2026 18:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772649218;
	bh=RQdiDeOtHfF6Pal/tLUKly0TFJY4YYJCU3MQfoJSd30=;
	h=From:To:Cc:Subject:Date:From;
	b=hE9wlb0+uDLHYpv2GW6Oyf5SE6oY6CxbZ2y8uIo9yqR/nFWcyhOIWV8SwNTuRFO3P
	 KTIed74zgo6T4k7IJsKU9meGMxAkupiLVeQ9uRzO4bfH0Mm35kmJtKl6DXnzI+kU67
	 4//Rdt7TV+kYXG9nGm8+bwgqHNG85kdKlINuxrFtNkISnVxmUgDxSEjYmKjajd0FS2
	 nB9i4sviIbBWzg8tQLP/M8echjkXgkydSPXu6rCTB3Nc2suu89DQ06a3IuCxRWKe65
	 FLZViJ3dcQdNGvnPJpysXm6EcxIoItOTBbLMzftvVAwaSzGeMDkteuihdbrcGISjeM
	 dvYZVyI7VpXxg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-iio@vger.kernel.org
Subject:
 [PATCH v1 0/2] iio: light: acpi-als: Use platform device for driver binding
Date: Wed, 04 Mar 2026 19:31:23 +0100
Message-ID: <6147175.MhkbZ0Pkbq@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 8681320690C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	CTE_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21345-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,rafael.j.wysocki:mid]
X-Rspamd-Action: no action

Hi All,

This series is part of a larger effort to switch over all drivers using
the struct acpi_driver interface to the more common struct platform_driver
interface and eliminate the former.  The background is explained in
Documentation/driver-api/acpi/acpi-drivers.rst and in the changelog of
the patch that introduced the above document:

https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/

The bottom line is that the kernel would be better off without struct
acpi_driver and so it is better to get rid of it.

This series carries out driver conversion of the IIO ACPI Ambient Light
Sensor (ALS) driver.

Patch [1/2] updates the driver to install an ACPI notify handler by itself
instead of using the .notify() callback from struct acpi_driver, which is
requisite for the driver conversion.

Patch [2/2] converts the driver to using struct platform_driver for device
binding.

Thanks!




