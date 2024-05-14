Return-Path: <linux-acpi+bounces-5807-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E74018C5CD5
	for <lists+linux-acpi@lfdr.de>; Tue, 14 May 2024 23:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8890CB227FE
	for <lists+linux-acpi@lfdr.de>; Tue, 14 May 2024 21:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278DC181CF0;
	Tue, 14 May 2024 21:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rj/n2Y+b"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18B9181BB0;
	Tue, 14 May 2024 21:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715722226; cv=none; b=bETeBXxe6RxegI+oW9fAAUi6mHquFHl7LD82/itGKCHk3yKjPqeNN25HuKfNT1/P/G6own6O7UPQRvjmkgYYmhKbVETfVmRlmlPp4tPsHMDRscWOYjz0rPI3kFpN5RPQFk9a7DHJz899e3aMLi5J5Q6kGAV1kxjnT5rwlR2pBnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715722226; c=relaxed/simple;
	bh=5vOQE39Hs8hbWu1guGqXqmxshwVZPQY7r81sAhcJ01w=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=tniqlIK26vWHtqnrbdCBEBd2Xk4UTUu+JCizrJ4oNf0PPYU6imlChdVuTE9zHrSD4qBEM2LDA3lAsOUC4bA/fQ2MMfr85+RXP+L13YSSE1os9G6gtjPAO8Ut491ySOC8jRnUftt+/Dg+Qk9IEd83JRzEgPKNWiwOY7YKXj3mtoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rj/n2Y+b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D1683C4AF08;
	Tue, 14 May 2024 21:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715722225;
	bh=5vOQE39Hs8hbWu1guGqXqmxshwVZPQY7r81sAhcJ01w=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Rj/n2Y+bSGM5T+RWICSdMCBG/J/T6Tr4w+6Jcmk2Cs1DFzImyKjg/C0PUCKywTWGc
	 hmQFuSyzlnOhDQA3aSXEnU7lMccGwXjLQ/5uovH7B327qqWa1bHbEnzv9bswGtx1S1
	 I1qgmY2MkNcS17JnuyWXLlKYCV9R8rj+kgKrhGMLebtU+zwoHm9hmdRAcjgQ9lmAUY
	 dn51PnttKMT9ZVQkQqtg2pAUhxNocLZcucfC5HY5OeyXhSWGpJPYbITLzS5DsQ2KZN
	 iOQM+P+2CKq37OB9YFnKzCkrpcHcaEBZukJ8BpAPOVy2x1xD3lMQ3A7BZCXQF3BYQu
	 Mxc4OjbMQoSyQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B2435C3274D;
	Tue, 14 May 2024 21:30:25 +0000 (UTC)
Subject: Re: [GIT PULL] Power management updates for v6.10-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hDjPb8n5wQODb==QMvp7ipEVpRoSqJ6pTii=_6XvRwEw@mail.gmail.com>
References: <CAJZ5v0hDjPb8n5wQODb==QMvp7ipEVpRoSqJ6pTii=_6XvRwEw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hDjPb8n5wQODb==QMvp7ipEVpRoSqJ6pTii=_6XvRwEw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.10-rc1
X-PR-Tracked-Commit-Id: de1c2722e07819c7ea65bb4bf37a2cfe2556095b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0c181b1d97dc4deaa902da46740e412c0d0bf9fb
Message-Id: <171572222572.832.15949032093452854115.pr-tracker-bot@kernel.org>
Date: Tue, 14 May 2024 21:30:25 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 13 May 2024 21:28:41 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.10-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0c181b1d97dc4deaa902da46740e412c0d0bf9fb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

