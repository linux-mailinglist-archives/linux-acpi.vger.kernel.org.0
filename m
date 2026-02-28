Return-Path: <linux-acpi+bounces-21256-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QECACZ0Ho2mg9AQAu9opvQ
	(envelope-from <linux-acpi+bounces-21256-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Feb 2026 16:19:57 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FAC1C3DFE
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Feb 2026 16:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B864330FBD9A
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Feb 2026 15:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A717A46AEC8;
	Sat, 28 Feb 2026 15:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lcp9Tl2X"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830E6466B6F;
	Sat, 28 Feb 2026 15:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772291951; cv=none; b=kd7hjYAWmdTyVHVb2ur5j/nvSSUkY21Qqq2KT/L9amA0L4T2F1XM8BqqVUO3BbTuXwj+SiHq467hCUJT32tVFlhGo0qEcZYU1Z8GJ7LR8Aa0sSuQnYF8Hgd63C4b2BlwoXAb3sP8zD1SyRW8kKCcSHXqYFSNJzA5jaUJoZkf5Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772291951; c=relaxed/simple;
	bh=3PzrQdCM4XI06JvkyfnpMeZS3dKy+BC0JnLn2bj4xXo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eeFICeJp/7q1RvevfvJJzTtTMPo5XN48mXjcuM5/QgPokyEeS8L8AOiJVBLFXm9mm3Y8LFaIc73pdimO2bILbfSjI00FbtxyPDZXppr0sJhDdXu5PcPjVOEcZE8Rw22s9u7+Spmgr0MHA20Ym8VAZjXTilQml7iHmypmGAVXh+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lcp9Tl2X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1431FC2BC86;
	Sat, 28 Feb 2026 15:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772291951;
	bh=3PzrQdCM4XI06JvkyfnpMeZS3dKy+BC0JnLn2bj4xXo=;
	h=From:To:Cc:Subject:Date:From;
	b=Lcp9Tl2XgKphe5EDzebuuhduyfOafqqZpQPU1D134llSOHE8R3c+jT3mvrJiOIhya
	 ieals/f7OoNjAeD3ydWyxNqGK6j8+9ub63IbPTA2FBSsDO1vVUGRCEg794x/QgrnOy
	 aiBVNi91osTnjNk0FNF2bjfS+oyb3Fa2njhplaU4MRW6ZMLNFoczweFv8QL3n3pr2E
	 xzxiGqtLXJLie+h2NLausw39zoCRTj0pXOlcTz8GZ0KdxjkypyvrNkkqhkWr48bUGq
	 fMpBUf776+v9WxGQBY6PvNyKJvo9Erpccgl39fm566mHYYSO6YRKpDaAe83wuDGc7P
	 JC6M/X/iflA3w==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, platform-driver-x86@vger.kernel.org
Subject:
 [PATCH v1 0/2] platform/x86: acer-wireless: Bind to a platform device instead
 of an ACPI one
Date: Sat, 28 Feb 2026 16:17:06 +0100
Message-ID: <3406021.44csPzL39Z@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	CTE_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21256-lists,linux-acpi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,rafael.j.wysocki:mid]
X-Rspamd-Queue-Id: A8FAC1C3DFE
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

This series carries out driver conversion of the platform x86 acer-wireless
driver.

Patch [1/2] updates the driver to install an ACPI notify handler by itself
instead of using the .notify() callback from struct acpi_driver, which is
requisite for the driver conversion.

Patch [2/2] converts the driver to using struct platform_driver for device
binding.

Thanks!




