Return-Path: <linux-acpi+bounces-21195-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPxAIRK3oGnClwQAu9opvQ
	(envelope-from <linux-acpi+bounces-21195-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Feb 2026 22:11:46 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA59C1AF819
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Feb 2026 22:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18AE03007CBE
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Feb 2026 21:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38AF44DB6F;
	Thu, 26 Feb 2026 21:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HeW0NKNX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA7844D029
	for <linux-acpi@vger.kernel.org>; Thu, 26 Feb 2026 21:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772140294; cv=none; b=Uc+EJp+0mnq5+CVoosFqzMASbbs60P0YODGYsawBM2odmJfJ5lqoTBavJ9OpUwCCkQKrMP/k6IhAgpEzfnL8SBXJqR4o1VW/yWBqcZ5kKL0AObDqRyZQtTJCfnQRP+v+vwUpjFJE+muMmJz2NHjUEnwLRe+f9bxRtMiPot+pgCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772140294; c=relaxed/simple;
	bh=mbN5C9Fq1cV1MyrDq59GzqvjYsLtaVEHnXF1HFfVphs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ZSriI+K6MWMbaYI8UoLmrQupFR/X4amf+k/JpWNtjI6HgiSuOr69+qW0RiZlIqi1tsnAH3z4S8+M3ZpiVaZYMQDbrX7cGS0+LjoDHV4usha9OrOrnUJrLlX+BCAwyFemSCMTC6r6Kd/SEnBa3BFyUloG6tEqHpFMlka7HHF/0bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HeW0NKNX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 872A0C19423
	for <linux-acpi@vger.kernel.org>; Thu, 26 Feb 2026 21:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772140294;
	bh=mbN5C9Fq1cV1MyrDq59GzqvjYsLtaVEHnXF1HFfVphs=;
	h=From:Date:Subject:To:Cc:From;
	b=HeW0NKNXezqXHBOjDqo83YEpqrsN8UPzoMLEgwY1LI/PfrAzP8NABAqWP+OOGflJ0
	 X+92oU6X2eKro0frTLLLXUlNp+yH3k9NsqdG+SGZw1BVmzZysOA4+eMpG+BZiMUBzQ
	 dt5It3drUZ+nRrDXtjeg9nQ58dPwnC9sQ5PURXmm7q+RuOOm/3eHXK2e9D6guncs5K
	 ORQpkdHdDp681VvdbYZqrKn4vR8GJuUU+lrY/p9h3LWSX4WE7A9J4RTUQQcxmkMGP0
	 u2dECnnIYs9XEE/uBG4OOJRfdplWHeJTC7YXhBd6VFMfSdTvwPa9Msjp8jS8eWXzy4
	 oPIhummOVfwTQ==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-679efb9eb0dso1023322eaf.2
        for <linux-acpi@vger.kernel.org>; Thu, 26 Feb 2026 13:11:34 -0800 (PST)
X-Gm-Message-State: AOJu0YwQxMwX8akzLMN6Ws1PNHGydDhyMX1hrYXY1dn1zTfUSgsRH6z9
	LPXGP2CVlUst7vw0FTZqXKL8Q9ZiHeNKRCQQjwsGfpRIwkaiWc1HY53kjAgey+MG8+emdHctkuJ
	MD6kLsKnStes7q6AYF0uNZOCY/oSk/8E=
X-Received: by 2002:a05:6820:1506:b0:679:953c:746e with SMTP id
 006d021491bc7-679faf0f2c3mr458273eaf.41.1772140293714; Thu, 26 Feb 2026
 13:11:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 26 Feb 2026 22:11:22 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h9VMwNSMrb_w2BGrv+fRDcUCJ-_1pYeDJ+oYigJovDLw@mail.gmail.com>
X-Gm-Features: AaiRm50aKPRqtovswum2gC3CbKkrFn5SyBo1GknyuOhuTRwuP6QTb_p77zGd19M
Message-ID: <CAJZ5v0h9VMwNSMrb_w2BGrv+fRDcUCJ-_1pYeDJ+oYigJovDLw@mail.gmail.com>
Subject: [GIT PULL] ACPI support updates for v7.0-rc2
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-21195-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-acpi];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: DA59C1AF819
X-Rspamd-Action: no action

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-7.0-rc2

with top-most commit 3d9b8b00da184f885c4db08fe5521f6a3e3f964e

 Merge branch 'acpi-pm'

on top of commit 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f

 Linux 7.0-rc1

to receive ACPI support updates for 7.0-rc2.

These add new platform quirks for two systems:

 - Add a quirk for Lenovo G70-35 to save the ACPI NVS memory on system
   suspend (Piotr Mazek)

 - Add a DMI quirk for Acer Aspire One D255 to work around a backlight
   issue by returning false to _OSI("Windows 2009") (Sofia Schneider)

Thanks!


---------------

Piotr Mazek (1):
      ACPI: PM: Save NVS memory on Lenovo G70-35

Sofia Schneider (1):
      ACPI: OSI: Add DMI quirk for Acer Aspire One D255

---------------

 drivers/acpi/osi.c   | 13 +++++++++++++
 drivers/acpi/sleep.c |  8 ++++++++
 2 files changed, 21 insertions(+)

