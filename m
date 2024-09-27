Return-Path: <linux-acpi+bounces-8473-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CE4988B4B
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Sep 2024 22:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BD302812C7
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Sep 2024 20:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A2B1C2329;
	Fri, 27 Sep 2024 20:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BHReUlbs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7858381B1;
	Fri, 27 Sep 2024 20:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727469120; cv=none; b=qqRAvDK81Ja2WGWPnmUX2Q8O4s8vLaDNLt7wfTRWHNcEzCfu55SR8DhiVp1lrJhDeKxPbpyX6awYJLLICnc3IYe6e1pqeQlrlpwVHGPLG0m6cS19SyoHIGQ4K8qmy8GDSTjccQZNFw1uN9AKDIEBdBm6K1BpAjX3fkM06dlE53k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727469120; c=relaxed/simple;
	bh=bidwh/5khsi2VjL1BDdIC2yleNFjh+z/eStChmaVtpg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=lm15uVq1ms8019SIlxKnqLuOTZ+CUOYn//wMIkYW3vw5HTjUkTJgwH0GPhvo+t0DIfnAj46yR885XdUlHQaVIqwNAKLTmPjUABZRTr9ZyuyHZoluRinEzrIoqjgpTMoxAjmDiIFsxnYj1xESQSVU0xvGYBgW3EmBm1Jokf5i03k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BHReUlbs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59960C4CEC4;
	Fri, 27 Sep 2024 20:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727469120;
	bh=bidwh/5khsi2VjL1BDdIC2yleNFjh+z/eStChmaVtpg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=BHReUlbssMFsX7Vy07WtV5DLN7h3Y1O1uBIWDIyePmn4iY2TE4b4rgblkTh4bnAfM
	 sXeJRVQtYlQcme2kcAjHC9BVTg6fEShqCoMUhlIk4PjarQIxlkP5+qgV/weJwSa0zo
	 4OlixuxvoeYsFb6Xk0i0qiHtoA/aYc+SEY0dCCr2Bgp+DyHkz9x8974HO/Zp4WI1PF
	 cThQqiBhhNZCTZv92HOdZFf9VBHxBXZaLSV4GsxM3QurQ03yVTJKIU2/pPwOfxRmyN
	 R119vUCth0aYZ7G1PE5npnTwfVbrgnAF+QS36HiB1vHXz6GnaULmbg9t8I4WRT0EbF
	 csEWuJ/X3PqXA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3405C3809A80;
	Fri, 27 Sep 2024 20:32:04 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fix for v6.12-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0iZO4f8q_BYYYkMsEPzQYmFG5GAQrj8=g0b7GV6Rmf=Bw@mail.gmail.com>
References: <CAJZ5v0iZO4f8q_BYYYkMsEPzQYmFG5GAQrj8=g0b7GV6Rmf=Bw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0iZO4f8q_BYYYkMsEPzQYmFG5GAQrj8=g0b7GV6Rmf=Bw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.12-rc1-2
X-PR-Tracked-Commit-Id: 4c411cca33cf1c21946b710b2eb59aca9f646703
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ad46e8f95e931e113cb98253daf6d443ac244cde
Message-Id: <172746912270.2074572.15020833689144502894.pr-tracker-bot@kernel.org>
Date: Fri, 27 Sep 2024 20:32:02 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 27 Sep 2024 22:17:38 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.12-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ad46e8f95e931e113cb98253daf6d443ac244cde

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

