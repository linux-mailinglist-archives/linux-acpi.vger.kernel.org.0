Return-Path: <linux-acpi+bounces-19931-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17252CEE6F6
	for <lists+linux-acpi@lfdr.de>; Fri, 02 Jan 2026 12:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B46B9302C225
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Jan 2026 11:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC8230E83F;
	Fri,  2 Jan 2026 11:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVpB7JVQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D662DC359;
	Fri,  2 Jan 2026 11:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767354861; cv=none; b=B7MGEVdf0Mu4alLbj+bVMtXfzYoNcHUJaQBs8m8aVbIMZXFJ462qPdsSXVn2HjbD2ZN6dZ9T3HKLyLNSxiC6Lc01izqaj7PlVviQImMlpmM62uU9DvB6MXgJACZko5Gbxdj4lTaMl5Ck0K/Zp+XK8BRmDiV/qITgXHUWd9q+too=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767354861; c=relaxed/simple;
	bh=5LTUA9YUVoSN5K+sOjgxETERayDa3Rke70MitTCdJZA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZjOMf9QL4NaoD7iIpC2KDAQ6X9Z6NqkLjROLJeKRmLV0dw6qlZvPxUcP6eOdkCDHk/1uay9Bh+i6/Gt3JCSMBkp5P/PTLC4w/klMGlE4BomzfDz9WK+/YlK4nIsilt8TNB4QEMMLdQ/mJ0K+77Vdpws8PBFPPA3u/xmPGmNbYhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BVpB7JVQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57FBCC19421;
	Fri,  2 Jan 2026 11:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767354861;
	bh=5LTUA9YUVoSN5K+sOjgxETERayDa3Rke70MitTCdJZA=;
	h=From:To:Cc:Subject:Date:From;
	b=BVpB7JVQieZPl2BBPFmCfkh+GkZujTAgS1ecMOiF8NbJncBqM5GABCzylhk0vGIyd
	 H7x0kDNU/zyHV5PzsMSmnlSKGOGY6HmMcww2QlbV5kyJvfQqyKf2b1j6KOJLRafjiT
	 CgietnIWUiHqUSsAM/fUO97hzl1tjbJhK/YFkJeyKHKokJYjmiJPymF+kS2M8J0Qmg
	 pd5Ho4a5Dmbdis0IHHVQMR/kb/9JKLs2fZqSIRvlDFADv7XZs60j+j1FX9nDQAB4Ex
	 hyh7R1wlR6ezjepoMS67jX0a0NmWJcGMXc8J+Bt69Seym8iQjUQwfGSgEEQ+3ppZy8
	 mlaYALwEKazNQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Armin Wolf <w_armin@gmx.de>,
 Hans de Goede <hansg@kernel.org>
Subject:
 [RESEND][PATCH v1 0/3] ACPI: video: Convert ACPI video driver to a platform
 one
Date: Fri, 02 Jan 2026 12:48:47 +0100
Message-ID: <12824456.O9o76ZdvQC@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

Hi All,

This is a resend of

https://lore.kernel.org/linux-acpi/8617910.T7Z3S40VBb@rafael.j.wysocki/

due to the lack of feedback.

It applies on top of the ACPI patches in linux-next.

The original cover letter still applies.

Thanks!






