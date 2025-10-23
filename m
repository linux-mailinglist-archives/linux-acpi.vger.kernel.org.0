Return-Path: <linux-acpi+bounces-18162-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD052C02A61
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Oct 2025 19:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 090DB188AAF1
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Oct 2025 17:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0246433F8BB;
	Thu, 23 Oct 2025 17:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ka13Czdm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C3833DEEC;
	Thu, 23 Oct 2025 17:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761239026; cv=none; b=TiRkefjC+nfJZySra0DGGBWp2PGQpLiVic8HQVoEi6gHaqz5OggXn07wpaE53QJCAtdANcWbi54VLcTBz7Ecv0jMbL21L448UU1NNO1s/7NeHCJU8TyWSyqlZkIGYKz7Pq1yGPPXV/l8iNN186F/QwQ1VnYypfYI0Ffg5+N7huY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761239026; c=relaxed/simple;
	bh=SKJXSeYoJ3zCyd7PtYBEdHGEIihCf4DcNZjXgsYYYmA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=LUmZLK1Vr0jERq189s+J0d6Pb+2m/2JMlSX4WQPgN/LFV4SXl7ip0U53eUo9vX8afa8uXnh9SFk8PM5C0vVc6M9flVGnUtqWhUpvnacUz/I/8GQVeH+PcWfdB2TzDGlmmA12goFGhmNyCqejC5YT8xmvW9EbCpsth+pVd2s+FJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ka13Czdm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F50CC4CEFD;
	Thu, 23 Oct 2025 17:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761239026;
	bh=SKJXSeYoJ3zCyd7PtYBEdHGEIihCf4DcNZjXgsYYYmA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ka13Czdmy2OjXwhnfRozeGLG2m2cp9BL3YJEUOxPkC04b7yJ16VFc8WOY/186G54R
	 0QAZJsdhXGonYRBbkq6hAQIuZ5/L8jlwd73XQERy3jLpfq4rio+4/krvo/waedo43r
	 4eNEu8uXpse7AzeBEQAn5Rz9QmdpsjauOnoYOpFn7oe11U5dKYSFY/Pp9QkEkBM7Eb
	 OpImI9nUhDnF8l0E/tYwxcAswvmTJls+KwZ8Cncg7BPG+Way7Xinsy6bOM/h1zziiP
	 4tQ/R5pb8CczK0fr6c5BFkJFI+GhWyW7C1zQ2IYBptKKqHO+/+GZlN5esMM8hdNMrf
	 YsocQlMzJ5iTw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB15A380A94B;
	Thu, 23 Oct 2025 17:03:27 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI support fixes for v6.18-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jjEjzcjVnToBjO7pnYbv18-e+7Wp_m+EjOx=3LhaF5Xg@mail.gmail.com>
References: <CAJZ5v0jjEjzcjVnToBjO7pnYbv18-e+7Wp_m+EjOx=3LhaF5Xg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jjEjzcjVnToBjO7pnYbv18-e+7Wp_m+EjOx=3LhaF5Xg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.18-rc3
X-PR-Tracked-Commit-Id: 114cbd67db825bfa42bc6c34875fc8409e5bba72
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a0b12d7b04049343d544ac92c8eeb5a2271235c3
Message-Id: <176123900657.3171289.11750661325678967137.pr-tracker-bot@kernel.org>
Date: Thu, 23 Oct 2025 17:03:26 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 23 Oct 2025 14:47:46 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.18-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a0b12d7b04049343d544ac92c8eeb5a2271235c3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

