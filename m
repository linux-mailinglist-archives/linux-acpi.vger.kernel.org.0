Return-Path: <linux-acpi+bounces-21048-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGAuH3IRm2lArgMAu9opvQ
	(envelope-from <linux-acpi+bounces-21048-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Sun, 22 Feb 2026 15:23:46 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6E216F5A1
	for <lists+linux-acpi@lfdr.de>; Sun, 22 Feb 2026 15:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9AC0304C045
	for <lists+linux-acpi@lfdr.de>; Sun, 22 Feb 2026 14:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4284B3502A4;
	Sun, 22 Feb 2026 14:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jIPbVQrJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F38534FF50;
	Sun, 22 Feb 2026 14:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771770090; cv=none; b=cpEtPzTPHvaGSMwEF5D4TiuORt4XJHoy5g3S0wiOrxBtusk4rIVbgUxJzexjHoowIBhIZ6GudWxVys+ZCV262YAr7k+LP9lzc/uBWe3TToKV8t7fn7N+baJPjgjEEEnj0pKM3GycVTsYwMe5jvE30pR2aAMw40aSN4sVofta3kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771770090; c=relaxed/simple;
	bh=GVWArgOJHC8Zxo5rAMYuzRy8kJVPHJqY0tiNnHQe8SU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=l1W39haegJ29Die5s4oinMOwmUth/J/a6xWynzf9SvPNzFAVrZHBtEIg65cXYSSQAWJ21mjYjSfcFq19K7X9nJxIGN0nMlfatnEtBn1mHxzbKNwIRvodp837yZRfMsbk9gvgYoT2M6DdTHN1UPsG3hqAwfTt+ksTJCq4Nsaoshw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jIPbVQrJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C687CC19424;
	Sun, 22 Feb 2026 14:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771770089;
	bh=GVWArgOJHC8Zxo5rAMYuzRy8kJVPHJqY0tiNnHQe8SU=;
	h=From:To:Cc:Subject:Date:From;
	b=jIPbVQrJW/QMFyEhO9OY73f7/eCfplvpXvyNdh0/SH1QxfXObep2z2Q8U0XwaSfRj
	 jdHKDEbqEDIEeZSEwlBkmcbWOr+hXYHB2BM8XsyBynahQ8i3r2pRs3xUOZo3rqEqMr
	 ud/YtKHXCBR0PNbJl3B/FhlL7wkiEa1hKfaNi9tlLhxRoqyxQsIN/J/8TFNIsgIbqj
	 WW4bGvl7+xCX0mtOzMxM3SOujrzwUlLi+O3gXSqz3VeqZtQmA0ZuSZh9/THamN17Yg
	 kMaZEGRD+1lhdxUq8ZxbQyHocuy1Pq/FLYAwmjKAScw42uoj1OigdNZIUtCtO9UytP
	 KUX/7tBl2QeWA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Danilo Krummrich <dakr@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject:
 [PATCH v0 0/6] ACPI: TAD: Assorted improvements and RTC class device
 interface
Date: Sun, 22 Feb 2026 15:14:51 +0100
Message-ID: <4727679.LvFx2qVVIh@rafael.j.wysocki>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21048-lists,linux-acpi=lfdr.de];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,rafael.j.wysocki:mid]
X-Rspamd-Queue-Id: 0D6E216F5A1
X-Rspamd-Action: no action

Hi All,

This is an untested prototype (hence v0), so please take it with a grain of
salt.  It is posted mostly to illustrate a point made in the discussion
regarding the RTC class interface at:

https://lore.kernel.org/linux-rtc/DGKTYBF8G6KI.3Q96DGYKYHAFO@kernel.org/T/#r49e1d3b1f47101a1240158f4e18d02e3e0c8b75b

The first 4 patches are assorted improvements of the ACPI TAD driver,
patch [5/6] adds an RTC class device interface to it and patch [6/6]
simply updates the driver description (no functional changes).

Thanks!




