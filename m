Return-Path: <linux-acpi+bounces-21352-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MERcNG9+qGmYvAAAu9opvQ
	(envelope-from <linux-acpi+bounces-21352-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 04 Mar 2026 19:48:15 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C13C2069F5
	for <lists+linux-acpi@lfdr.de>; Wed, 04 Mar 2026 19:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 52DBC304FAC4
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Mar 2026 18:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43C63DA5D7;
	Wed,  4 Mar 2026 18:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rTbHOdJF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A131D3D75C4;
	Wed,  4 Mar 2026 18:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772650009; cv=none; b=pvDPPcnK8LaYrvyegGdD2MeeqY0BBiOeKPSecsoXML0lMqTiX0hgP1huzNnSTSj6JsDRtcjrDWFhjxS1DVWOdp50uUVIoNqdQ/TlcMWcz5oo7O82lhtDuqyeTwiGasZepRXrz60q+IZgf8wz8Kl7jT98mE1z3z8lBtFALGyAzSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772650009; c=relaxed/simple;
	bh=JcSKSxzdPzOErYA+1dovArclnNI+XLgbFAD5iZnDgSk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZTy04ciYhPIPjbgKkd/Hdj2yYRzNs5n1GHcVi/22da/NraVD/TsIk58x5uKJqELweJy+mBrx5nLtYVvBpp+MBBOaivzmey8trsOmZRVvfvnx6bLw8aLabKOT9JiL4Pd3IV8T5t+eIc9eFVYF3zlekQObt0ZMP+MqRMFAKWnh7Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rTbHOdJF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97567C19425;
	Wed,  4 Mar 2026 18:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772650009;
	bh=JcSKSxzdPzOErYA+1dovArclnNI+XLgbFAD5iZnDgSk=;
	h=From:To:Cc:Subject:Date:From;
	b=rTbHOdJFDMFKv5mpphumlif/prEFG5ImwIwKoSUvOqRLiIw7P8FA0jl/AsetWFTbY
	 sJiFtcGhuy7kAOKbktDopEsfYWQ/bHo4Squ9LWPgk0K6ygX1hao65qe18Roww79Wos
	 M6kP36iNLpe+/of0KLXNj+1wBE8aYR2e9bQiwF4d7nHOx5kQPQ/6jaN5GH8EgARm3U
	 y5J/d2iDXjoH4OZYMPBHIyVoaUapZDX+V8f3ny8XlavzF7OTriTCmnJuLkg1r4vYUR
	 B23dJ0jMpa8J21KbuzDsSI4qzdMiuG5c6MvHt69kBVfkFjEDmDU42o7QtSUTINb45L
	 d6PPid3rUvwrw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: chrome-platform@lists.linux.dev
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Benson Leung <bleung@chromium.org>,
 Tzung-Bi Shih <tzungbi@kernel.org>,
 Enric Balletbo i Serra <eballetbo@kernel.org>,
 Ravi Chandra Sadineni <ravisadineni@chromium.org>
Subject:
 [PATCH v1 0/6] platform/chrome: Bind drivers to platform devices instead of
 ACPI ones
Date: Wed, 04 Mar 2026 19:41:39 +0100
Message-ID: <2274474.Mh6RI2rZIc@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 7C13C2069F5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTE_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21352-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,rafael.j.wysocki:mid]
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

This series carries out driver conversions of Chrome platform drivers.

Patche [1/6] converts the ChromeOS privacy screen driver to using struct
platform_driver for device binding.

Patche [2/6] fixes a wakeup source object leak on remove in the
chromeos_tbmc driver.

Patch [3/6] updates the chromeos_tbmc driver to install an ACPI notify
handler by itself instead of using the .notify() callback from struct
acpi_driver, which is requisite for the driver conversion.

Patche [4/6] converts the chromeos_tbmc driver to using struct platform_driver
for device binding.

Patch [5/6] updates the wilco_ec-event driver to install an ACPI notify
handler by itself instead of using the .notify() callback from struct
acpi_driver, which is requisite for the driver conversion.

Patche [6/6] converts the wilco_ec-event driver to using struct platform_driver
for device binding.

Thanks!




