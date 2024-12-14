Return-Path: <linux-acpi+bounces-10136-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A010C9F1BE6
	for <lists+linux-acpi@lfdr.de>; Sat, 14 Dec 2024 02:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3A5516A069
	for <lists+linux-acpi@lfdr.de>; Sat, 14 Dec 2024 01:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477B5101F2;
	Sat, 14 Dec 2024 01:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fn0lcLEP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2078BEA;
	Sat, 14 Dec 2024 01:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734140109; cv=none; b=O/G4QOdG+60yB0ID0syJ8vaAeatr5fpgFT5SxaOMNAPwXfaoGvALve1eG4PIKVYOqMWEZXqNNDWOJAB19//pN6No+qaLFV2dEhPim5i98Fct8zXe2sfCpoKcHKtYI7HpJivwQUDzF2dxNzFP6phk3TKfJx1Ax8h//+SpPKWLkIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734140109; c=relaxed/simple;
	bh=ZkuB989E3MC1XMZNjx13akqfS4kpP4dJFO6T7Frfj1M=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Ru6TqhPMzVD83igJ30+X57UDZGSJF9swKmZ/2lgRQjcNRk1nbWB0h+K2zi4IE4DGeSz7X03r/gRSJpQsjn0QV3Y1QuCqtqx+Hcsjxpj5qn5Z/HORHdl73x/ay6uDaPKfTYDGhb8sz1KfoJksdMRRYonnGU1rM7kKEg8FOOC95tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fn0lcLEP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00CADC4CED0;
	Sat, 14 Dec 2024 01:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734140109;
	bh=ZkuB989E3MC1XMZNjx13akqfS4kpP4dJFO6T7Frfj1M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Fn0lcLEPpr17KSickt6srama/lrDu95bOGZOGxwXM26xYY2nfTiHvwv7ycEWcyiP5
	 6dIEYdXUEPOSHAAyJMZ79xuhF9j8a/nVknsxvR3RGlSRFK+ZJRyo90ZcQoYsLAlTOl
	 Y2XUCATMHi2n5eUbnv9uImfnQWF1ke/PzaSj/gxXyLChp1XYpxfG/SRez/sAKE3xbo
	 nrNvz0JLJtpMF5scPAodyEQDKFIYzgGvhseqC7vqAV+f1ExpQX4qiFG2MwFKPOaBA+
	 RcoWktDmctDE6bbSpxCvOiqg6yxpGAyG0tFYdy+wzQN+KwAmcSwAK0QA4A2r+4e+Vk
	 v4qAbUqHRXfJQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0A9380A959;
	Sat, 14 Dec 2024 01:35:26 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fixes for v6.13-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jUChwwKBfcPrUJ+05ULOJ1dtng=f=7T8iHjBce3k5Bhg@mail.gmail.com>
References: <CAJZ5v0jUChwwKBfcPrUJ+05ULOJ1dtng=f=7T8iHjBce3k5Bhg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jUChwwKBfcPrUJ+05ULOJ1dtng=f=7T8iHjBce3k5Bhg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.13-rc3
X-PR-Tracked-Commit-Id: e14d5ae28eb28c5edef53bd648037d2bb4fce1b3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c810e8df9668d378430862ceb5eeff619da28509
Message-Id: <173414012519.3218065.35539358761682484.pr-tracker-bot@kernel.org>
Date: Sat, 14 Dec 2024 01:35:25 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 13 Dec 2024 21:59:34 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.13-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c810e8df9668d378430862ceb5eeff619da28509

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

