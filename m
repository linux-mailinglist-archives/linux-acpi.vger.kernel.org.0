Return-Path: <linux-acpi+bounces-826-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 844CC7D1937
	for <lists+linux-acpi@lfdr.de>; Sat, 21 Oct 2023 00:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F2AC282635
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 22:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA4C35502
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 22:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uhMMC7D4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783E8249E3
	for <linux-acpi@vger.kernel.org>; Fri, 20 Oct 2023 21:08:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F30F2C433C7;
	Fri, 20 Oct 2023 21:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697836080;
	bh=r3v80w6Wcqh/7K95U1NJAWREKtTllxrfj7m6laTXixQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=uhMMC7D4348x3m4ODSsAiIg2hNTNXXSM91i8pOWxkcNyAG680wAPYSwi8QnjKme+7
	 O+3VIsjCdh4rtW0cNIdRI/HT+yb9GpHWQzgoosOIDHUHB51yhHetdB0nSX+vYw1+5o
	 0su8jKu9XzMqHaOYOEez+U38QD0YnTQMKMxd4ybySzdSMUkfxeyuCESZqt85f4pmm5
	 6XgnZO19Oj8NvwUz01zY4wyHPjxzizvPaN3n9HTJby+q3ml+zOuEX25dznlgfvs1EO
	 SnK2zYRZu2u0+pALx25hz908hJrGd8UEdA2tmVVFSXMOMOOvLGAJEplYQzeCkUqofU
	 GgbhnM6PP3VOw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D6EA6C595CB;
	Fri, 20 Oct 2023 21:07:59 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fixes for v6.6-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gJZdGLmJQvKcOtVuJr1XX8J_3kH2jg2rUM1=_1XPCknw@mail.gmail.com>
References: <CAJZ5v0gJZdGLmJQvKcOtVuJr1XX8J_3kH2jg2rUM1=_1XPCknw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gJZdGLmJQvKcOtVuJr1XX8J_3kH2jg2rUM1=_1XPCknw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.6-rc7
X-PR-Tracked-Commit-Id: 9caa3a2de955238df742572812178568fed173f7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f20f29cbcb438ca37962d22735f74a143cbeb28c
Message-Id: <169783607987.30992.4792776334030206387.pr-tracker-bot@kernel.org>
Date: Fri, 20 Oct 2023 21:07:59 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 20 Oct 2023 18:39:01 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.6-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f20f29cbcb438ca37962d22735f74a143cbeb28c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

