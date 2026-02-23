Return-Path: <linux-acpi+bounces-21060-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBCcJgh1nGmyHwQAu9opvQ
	(envelope-from <linux-acpi+bounces-21060-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 16:40:56 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D9A178E2E
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 16:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 52413309D0AC
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 15:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B9F2FFF89;
	Mon, 23 Feb 2026 15:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JGKA0CmT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6048F2F6918;
	Mon, 23 Feb 2026 15:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771860855; cv=none; b=LGuFRnkQYF0XRLJybGE3Qn7L5HifrsL27hcYUx39lIGnpQoQlpzO0EnmmCpz5Tm7gZNdFs/7JfsnFrgyFDPGxt+RfMplGdUdbNaIom1Ce70XmtgbTBM8jsvNPnNEY4xX3WYPJRq3eQBPx4oLhJyUgoB8ROv+TyOJbHVE7QSA/AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771860855; c=relaxed/simple;
	bh=s6a2z9qba9B+ONUvseftMp8bheho8l6Zjw7fwTs9awU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WPiGkn3llurIGV82zRfuNg4vZxPTtax2IH+o7+T/4RlMj2dE4FE2clsnPEZGBfb/EnhgwNfIWEAwG9OdGOvyjmt1JsAijCTz/Ap4oqRXhN1g5Bg0LlZmHLrtnQdfmznWMeOttIT7zlWfnnAAdl5ut4y4eKzfB9aax6axhD6uzFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JGKA0CmT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1BD3C19424;
	Mon, 23 Feb 2026 15:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771860855;
	bh=s6a2z9qba9B+ONUvseftMp8bheho8l6Zjw7fwTs9awU=;
	h=From:To:Cc:Subject:Date:From;
	b=JGKA0CmT49l66gDwUvk4LFy1an0ZHeCCKRXLvYDhJ0Oaln07L4EBSe9obd6hSn38M
	 5DvSAPnfyqw3yamsJBx3GHRaqSPJvIdChei9PoPD+AsXmHHPHaCE187nlVBDdSeDsr
	 E7W2R4Onw4e8z1aTocK0qxSoO0/OVWCsd+IxwchshR8VFWa7alDpI6nBDkvDktFZCZ
	 H6ZnEscQIS8YLb9poDewHy2R0VF4Fo2IS0UA/KkUTLh8/FF8r+lEw3y5JxGwJnHsVI
	 9bc78k0iyt6YIyhk6xaOIDNaLY7sQEWjJ0J9OxGR3x5KZ2mkSAM0VpbnZ9CXVHDf48
	 XNOjPeLvXfk0g==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, x86 Maintainers <x86@kernel.org>,
 linux-rtc@vger.kernel.org, Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v1 0/8] ACPI: x86/rtc-cmos: Bind rtc-cmos to platform devices
Date: Mon, 23 Feb 2026 16:27:16 +0100
Message-ID: <5983325.DvuYhMxLoT@rafael.j.wysocki>
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
	CTE_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21060-lists,linux-acpi=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 42D9A178E2E
X-Rspamd-Action: no action

Currently, on x86 the CMOS RTC is represented by a PNP device which
generally works, but the amount of avoidable code entanglement related
to that is a bit over the top.

First of all, in order to create a PNP device for the CMOS RTC, the ACPI
PNP meta-driver needs to be aware of that device, but adding the CMOS
RTC device IDs to acpi_pnp_device_ids[] was not sufficient for this
purpose because of the CMOS RTC ACPI address space driver that added an
ACPI scan handler for the CMOS RTC.  That scan handler simply installs
the requisite ACPI address space handler for the CMOS RTC address space,
but it also claims the CMOS RTC device which prevents the ACPI PNP scan
handler from taking care of it.  That's why there is is_cmos_rtc_device()
that needs to be additionally called by acpi_is_pnp_device().

Second, add_rtc_cmos() needs to check whether or not the CMOS RTC device
is present so it knows whether or not to create a fallback platform
device for the CMOS RTC.  The way it does that is somewhat less than
elegant.

Finally, the rtc-cmos driver carries a PNP driver interface so it can
bind to the CMOS RTC device.

Moreover, on some systems the CMOS RTC device is the only PNP device in
use, so if it is represented by a device of a different type, the PNP
subsystem can be compiled out entirely on those systems.

That can be achieved with the help of the observation that the rtc-cmos
driver actually can work with platform devices already and the only
change that needs to be made to it in order to make that happen on x86
is to add CMOS RTC device IDs to it along with the related
MODULE_DEVICE_TABLE() declaration, which is done in patch [4/8].

However, for the above to work, the requisite platform devices actually
need to be created and patch [3/8] updates the CMOS RTC ACPI scan
handler used by the CMOS RTC ACPI address space handler to do just that.
It also adds a bool variable to be used by add_rtc_cmos() to check
whether or not to add a fallback platform device for the CMOS RTC.

Before that happens, patches [1-2/8] prepare the CMOS RTC ACPI address
space handler for the subsequent changes by rearranging it and fixing
its interactions with the ACPI time and alarm device (TAD) driver.

The next three patches, [5-7/8] simply drop some code that is not
necessary any more.  Patch [5/8] drops CMOS RTC support from the ACPI
PNP meta-driver, patch [6/8] drops the walk over PNP devices from
add_rtc_cmos(), and patch [7/8] drops the PNP driver interface from
the rtc-cmos driver.

Patch [8/8] is a bonus cleanup adding the ACPI TAD device ID to the
CMOS RTC ACPI scan handler in the CMOS RTC address space driver, so
it will create an ACPI TAD platform device after installing the CMOS
RTC address space handler.  After that change, the ACPI TAD driver
doesn't need to attempt to install the CMOS RTC ACPI address space
handler any more and can be simplified quite a bit.

After all of that, the CMOS RTC device IDs are only used in 2 places
(instead of 5) and well over 100 lines of code that is not super-nice
go away.




