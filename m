Return-Path: <linux-acpi+bounces-20474-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNmSBc68b2kOMQAAu9opvQ
	(envelope-from <linux-acpi+bounces-20474-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Jan 2026 18:35:10 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DDADD48A6A
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Jan 2026 18:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CFFEF806F4E
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Jan 2026 16:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62EB544CADD;
	Tue, 20 Jan 2026 15:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eac/fBx6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3516344CAD0;
	Tue, 20 Jan 2026 15:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768923915; cv=none; b=HBCqKCEVSg2R4RkMfQpanLuzuKRR6kbQVDRL/zUnNrHxzl+dKwuvMgOEyD2APmiNDUyvxHgMYimviSlvcxapKpYjfVsFhWWhA9JuCevvtuCVttGFBOVN5YtHKNt7iqdbCm3o7S3oVxgJOKlbNHytGf4W449/psgtSU/HyF741Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768923915; c=relaxed/simple;
	bh=7qWRI5TEMbhJwoDvCA7wEdITDjqQD7+a4DGBF4uDdlk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FfFSW42aXyvezk552OPCrjb1GRmlUUaMbB3YgdUNuCUGYKAfTdJNSbTZ55ij0IHKc3qNSTaONEqYm4YH5eNUgBPUOr1m9OkcMMfWrF4TroU0OC5ptaM6lLtiPQnzlM34rYBvBW+Jl3t/yNOEMG/k8YeRIMZKTYHzvjEioK2D/F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eac/fBx6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A47A1C16AAE;
	Tue, 20 Jan 2026 15:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768923914;
	bh=7qWRI5TEMbhJwoDvCA7wEdITDjqQD7+a4DGBF4uDdlk=;
	h=From:To:Cc:Subject:Date:From;
	b=Eac/fBx659SpDlgJImaVB+pxGBVIEoF3n6gpD7KVsUtXLvLkUo6oNKQcYXkgDqM6U
	 FejaC4LWAV/6tVtnMZm7aVY1d8IZ0DbehbDIUljTgr3dkrfC0VaxcxFm3/S0zr/N4Y
	 +t/IjMi0z/faM/vZGjNr8RT44KcHBvNsBl5v2WviNMKMaJ/KPfpzuLvK0acYWG1vUg
	 dt2p6YewaINw+Hck9CPp2aUfZsGVv4UwPTp7ZdJKjbTGC7YHmnNB5HvKN374m9TsTI
	 1BRK+qNqCaCdsJnVyRWC+Ng/nwgBywR32ORuAC8u6q/aUcKa0Wwpw2apb5K6Boiyv4
	 p2vuelXDuwZ/w==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Hans de Goede <hansg@kernel.org>,
 Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Kenneth Chan <kenneth.t.chan@gmail.com>, platform-driver-x86@vger.kernel.org,
 Azael Avalos <coproscefalo@gmail.com>,
 Matthew Garrett <matthew.garrett@nebula.com>
Subject:
 [PATCH v1 0/2] platform/x86: Fixes for leaks in panasonic-laptop and
 toshiba-haps drivers
Date: Tue, 20 Jan 2026 16:42:41 +0100
Message-ID: <3026924.e9J7NaK4W3@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTE_CASE(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,nebula.com];
	TAGGED_FROM(0.00)[bounces-20474-lists,linux-acpi=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rafael.j.wysocki:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: DDADD48A6A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi All,

These are two fixes for leaks in the panasonic-laptop and toshiba-haps drivers,
in the "probe error" and "remove" paths.

Thanks!




