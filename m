Return-Path: <linux-acpi+bounces-6923-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A80CD93348C
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Jul 2024 01:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64173286FC2
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Jul 2024 23:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403361448F2;
	Tue, 16 Jul 2024 23:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZQacgHQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149BB144312;
	Tue, 16 Jul 2024 23:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721172487; cv=none; b=DGvM1lENW2Hxx/J/hoze1Stm/hy7b0zQH6KsGb8ET5zb7qjlyKUYPTARWWOgX9OLiWQnbSXhjf2Bhw7KD48CuCkVo/eskFrJqIIxrRa5LsGfgE8N0Fv2OzqEvgILGP0aXLHb53a2rvIWZ6WZLGl25/q2kzmCglSc0o3Hd97/fqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721172487; c=relaxed/simple;
	bh=Jamb/algZat8QRaoEa7lxur5B/lDH7sUdQebPu2d9T0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ixHPtd0HJ/po4NQc1nREUj3TyZk18GHvQuMc1Rfey/FFIlpEuVA9bs0lOW4YZEicG+O4p9tRT3TCo0J8yRVXa+rEQixJIjOwiChQ+Ds+K5KqYkrSVLlB05Kf+7/5lYD7KN44o/fdmWfrWxHZLZEDCAo6g1XSo7UAJHKRIu0ru/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZQacgHQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EA74BC4AF0F;
	Tue, 16 Jul 2024 23:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721172487;
	bh=Jamb/algZat8QRaoEa7lxur5B/lDH7sUdQebPu2d9T0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=MZQacgHQjGB64DjjWUb0rmSnV2ooj7gDHjs1ihK+exLkj9c3I++FOpd7U/ZihKlIW
	 I7iQhcUJa8hINgQBYXw3pPjKmSqsQRVUSYnu1AMyk9UnmSRpD+HIwOcQeMKMe0SCKf
	 pJVn423VDpwB48AvBYJk9kfHLCGkPDpSSTzfbMkwehLqfc6fVLoGhPFcMJTAKAOlnn
	 qpIB9H3cccdh48l1IMSZ90cxlNXb5F91+deix9PLfFsM0MwQ4XffWWkK/2cZsKsX6+
	 yvCCPa9cT5adXy9OPRSKmbF+wTJLC2WkH5R8kVIjCbFJtMYYGSQmXu4QM/zxOtEqRw
	 VFe/TJXNtbl+g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E2209C43443;
	Tue, 16 Jul 2024 23:28:06 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI updates for v6.11-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jtWq5kTmM_DRPwFZZCziqY11TMP8rYtj8UQHHfRKX6tg@mail.gmail.com>
References: <CAJZ5v0jtWq5kTmM_DRPwFZZCziqY11TMP8rYtj8UQHHfRKX6tg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jtWq5kTmM_DRPwFZZCziqY11TMP8rYtj8UQHHfRKX6tg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.11-rc1
X-PR-Tracked-Commit-Id: b77b0bc85b117119764107f3ee76e8877bf826ab
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 923a327e8f2257ab7cd5485cb5d8db92c965dfca
Message-Id: <172117248692.20323.5338360240168392398.pr-tracker-bot@kernel.org>
Date: Tue, 16 Jul 2024 23:28:06 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 15 Jul 2024 21:44:33 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.11-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/923a327e8f2257ab7cd5485cb5d8db92c965dfca

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

