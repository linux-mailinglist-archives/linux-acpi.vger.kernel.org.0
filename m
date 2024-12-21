Return-Path: <linux-acpi+bounces-10256-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AF19FA20A
	for <lists+linux-acpi@lfdr.de>; Sat, 21 Dec 2024 19:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3F6A18899FA
	for <lists+linux-acpi@lfdr.de>; Sat, 21 Dec 2024 18:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DD0178CC8;
	Sat, 21 Dec 2024 18:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1Ze8X9b"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265241779AE;
	Sat, 21 Dec 2024 18:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734807396; cv=none; b=UF3hfL5TyGl7RAa0wzSnl6TFQgGB8CfMtHpbQNKDmZvLWUsHk3d52r3nTLHy03j3ufeLSCsjvEtiV4NPiE3lxEMVaqsumx09ke510dludm0fx4ZrYaRGwLCJhaCTIAuYBqSxIdMR9iJTsht7vDjnr2KwhkkX6r3oz8wyQUT5wFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734807396; c=relaxed/simple;
	bh=x9Z8iArBNvIuhC4oG4f7xKmzVgJHJsj+wf0ybDTVYIY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=oUbmxuho78m6BD2A6+rzWGVYwiJYnbURI6l00wXc6GvXpAEzLC/FBnA1Dm5lw6KzX8zyQq3fbAYxAFY77Gh50bULBrfFyxGg9BaNrK4LXDm8mGTHsqxvYdOZdWTyGlRv/GKe25tP+HOFWo9l3hG0JFZQ/Av2Ap1TeoG5UdOOK/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V1Ze8X9b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7F27C4CED0;
	Sat, 21 Dec 2024 18:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734807395;
	bh=x9Z8iArBNvIuhC4oG4f7xKmzVgJHJsj+wf0ybDTVYIY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=V1Ze8X9bsPSQdWgEQlHbj+yN31KemzPAGvJQil2QKxBOZMdbdyvmOMJKfE+9MxoOQ
	 numUfMMLWdX/HFPDaQZnHEo9tzhJlQfNU7+lTZLYY7NiCsMvHc5Rvmg+S5werdoyef
	 5oVlKYMd6jDf9lx+sd4ZzC/eyfsD2ADmJbr3FY4O9ph/0WfT0iNYXYNYgfNkdsUg5M
	 jtn4gljLLYpmjrDsjUAS6fVz+rJ6YB3CIh5q1REB/vH8JrtwFNdUXwjpT44A3H03qC
	 dUm4Sm8E0w3RHvo6BT9337/sKcuj9ashGNx8G3GuBBsiWCbDPxChqmhmyD/pi3R4K1
	 aMGBrm5OE/MqA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB4C03806656;
	Sat, 21 Dec 2024 18:56:54 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fix for v6.13-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hO2aekS5K0o07h=+sK2+dK24+RVy1JbJMTYCZgw6zphg@mail.gmail.com>
References: <CAJZ5v0hO2aekS5K0o07h=+sK2+dK24+RVy1JbJMTYCZgw6zphg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hO2aekS5K0o07h=+sK2+dK24+RVy1JbJMTYCZgw6zphg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.13-rc4
X-PR-Tracked-Commit-Id: 0674188f2f4d38d74aa863f17373d76256f2ed09
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5100b6f9e7bfc520e8129a5042a4bdd7dd486df6
Message-Id: <173480741368.3207643.3587681995080309946.pr-tracker-bot@kernel.org>
Date: Sat, 21 Dec 2024 18:56:53 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 20 Dec 2024 21:46:20 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.13-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5100b6f9e7bfc520e8129a5042a4bdd7dd486df6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

