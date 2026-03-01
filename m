Return-Path: <linux-acpi+bounces-21289-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMbsGvY8pGlnawUAu9opvQ
	(envelope-from <linux-acpi+bounces-21289-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Sun, 01 Mar 2026 14:19:50 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDDB1CFE2F
	for <lists+linux-acpi@lfdr.de>; Sun, 01 Mar 2026 14:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 582A6301396D
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Mar 2026 13:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0AC932B9A1;
	Sun,  1 Mar 2026 13:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SyyJj+R4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7FD2D97BA;
	Sun,  1 Mar 2026 13:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772371172; cv=none; b=MUasW5Uz0TpURfTsAPX/Hpj2tFX1oscP6XJIr3+tyLkuRP7Zb3eePQpN9e3174P+7NB9Z28cKXJ6pvZl0WjHMWWfYt8f+cgLxOzk+vVJigTcuMrbTFUDBflz1AuKxOcecrJ509WENmpEUw3WGoiNUTDKvKfEXu/YjOAGkicmTsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772371172; c=relaxed/simple;
	bh=zJ0F6o4geoAAqzE9/XwWR1ABpdm/VoPF34FCss5gwN4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JldsI2nBPYk3D8VCPN0eGRMzwhAwefhu4zXL8bPq75ksLsFWoRs63xjcQTLp36wVP4Fsj0qUeY/CPhlNOVrb7eGy3UeXtWrxBppLQpWqQdqZUMx8wmA7eq2/Vv+MGB6yKzvbT+JSVGHnWHwJJls9V4JIxf8Llu7Sszowu6QJImY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SyyJj+R4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDF88C2BC9E;
	Sun,  1 Mar 2026 13:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772371172;
	bh=zJ0F6o4geoAAqzE9/XwWR1ABpdm/VoPF34FCss5gwN4=;
	h=From:To:Cc:Subject:Date:From;
	b=SyyJj+R4qPFh3ZewVrXx5j73xWTyngC1GCrDsV33LyzQKfvP2OHDkZ/n8HesSd9/a
	 8GMAMCHXNJ0CjN8KtQT312XV6tpq9fKe5kcEP5inrPlR7RAyxs7kPclaKoH+xJ1Hej
	 G6UDb7zYZULwAvPeOw/4eVcWUnqRirDDKoluq7oWZj251F67WzaiGhQtDq8oe3K+WP
	 S2mzcWLWSpJq315tFzkaNE2AewTZfTkgeUA4P8QaQkRZ2RvFg6xF8yHCPTEgdZW5xw
	 8Bc7usSMdrq8bv0BBN9BoZp3KmVodAEUoWbVQtc1SoZNJSkGAoAB3sF+Dyt42+tDP1
	 977iHe/e8X2LA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>,
 Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, linux-hwmon@vger.kernel.org
Subject:
 [PATCH v1 0/3] hwmon: (acpi_power_meter) Bind the driver to a platform device
Date: Sun, 01 Mar 2026 14:16:03 +0100
Message-ID: <5974797.DvuYhMxLoT@rafael.j.wysocki>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21289-lists,linux-acpi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4EDDB1CFE2F
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

This series carries out driver conversion of the hwmon acpi_power_meter
driver.

Patch [1/3] removes some redundant checks from three functions in the
driver to facilitate subsequent changes.

Patch [2/3] updates the driver to install an ACPI notify handler by itself
instead of using the .notify() callback from struct acpi_driver, which is
requisite for the driver conversion.

Patch [3/3] converts the driver to using struct platform_driver for device
binding.

@Jaroslaw, testing this on your systems where the acpi_power_meter driver
is used would be much appreciated.

Thanks!




