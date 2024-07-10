Return-Path: <linux-acpi+bounces-6845-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D77ED92D60B
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Jul 2024 18:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 752A9B26BE7
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Jul 2024 16:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7CD194C90;
	Wed, 10 Jul 2024 16:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OSLTIdt0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519D4194C83;
	Wed, 10 Jul 2024 16:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720628053; cv=none; b=Q9aETJpkikyKp0QRcdf/PNhDlSLHCNSOmYDDzlG/rLHXgv2aNxTkebs03qjjBIROzSvrepc+EBdY7tQRbSMBYhQtvFdj+uAivGoyDnpFdH3igBaYiGwjN+cZLrqquGx4Eua8cpJ9TE7dgbyB5OtMOn8Ot7K1xn47UazzfdU8VHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720628053; c=relaxed/simple;
	bh=V676hMHxKK7t498FOVgn/+JVjxiD/nPL7FG+nRYMDks=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=UoLGvT135z6hJzzn83nfRBF5vW3GM2cidbE0VaKg+pXw4RUt0lbjUDBXe0MKw/As8cieUmhGUVnsbUpqhTMk6QynLSGMCVK2+UV8tAM2crJ3KBMwvTvsQTtkYqUoEF8KuzvWP2lOpAra+Ctmj4noyODg3qfShdMRAlBtgLxFBDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OSLTIdt0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 30285C4AF0A;
	Wed, 10 Jul 2024 16:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720628053;
	bh=V676hMHxKK7t498FOVgn/+JVjxiD/nPL7FG+nRYMDks=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=OSLTIdt0kl+MNpcJwBvAoVXApnnDeR8d4ycUhzBYfuPBi63X93nP/MU1iE3cJyHNq
	 dykrtL+aMfIvbtYtGr3FIe1uMHizomxWYcQPml3N4yO1jBajriN7GYOcLXVJ9pDRA0
	 +jgMPyNlNzryNmaRTSMcQFjaSU10CF36H3ErP/prxElKn6XAjjmxkWQoJ8y4dUNJFK
	 GP9KhAUKs00xv9H+cF5NTgu04qY0nU7GkjNpkuB9Xl91KULgoSVebIcAOC/0cGggc2
	 K7az+Ds6ML8R9QOVAKe01PNH3KQ0JUchOVfOIEam5Y8qLYcf+opeXbhKe6T5J/JcL6
	 PSbib1tUAgBmA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 18D74DAE95B;
	Wed, 10 Jul 2024 16:14:13 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fixes for v6.10-rc8
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0j01pmgnms9cPKeUn=5TNH_g3cwYB6Wd0kCuEic42PRgA@mail.gmail.com>
References: <CAJZ5v0j01pmgnms9cPKeUn=5TNH_g3cwYB6Wd0kCuEic42PRgA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0j01pmgnms9cPKeUn=5TNH_g3cwYB6Wd0kCuEic42PRgA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.10-rc8
X-PR-Tracked-Commit-Id: d92467ad9d9ee63a700934b9228a989ef671d511
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 130abfe9a1841189975f3770e825e441acd3c87c
Message-Id: <172062805309.17113.17222400044786513286.pr-tracker-bot@kernel.org>
Date: Wed, 10 Jul 2024 16:14:13 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 10 Jul 2024 12:58:50 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.10-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/130abfe9a1841189975f3770e825e441acd3c87c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

