Return-Path: <linux-acpi+bounces-8723-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B403C99ACCA
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Oct 2024 21:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 618F41F25814
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Oct 2024 19:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770371D0DF2;
	Fri, 11 Oct 2024 19:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5r+wo2H"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5E01D07AC;
	Fri, 11 Oct 2024 19:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728675254; cv=none; b=rlQgkJxXSOhX5g5K5HYchn/DEF33awHT70rO7n9AIvdIhhIh7OQ32syMwWV4LDC19fPm4EqetG4iOXBq+QwbRApIuqOoYP9q6A3kUqjnH1E/c+h/Jm1J0JqdTi4RBjhgrwD9mRiS3qg2JQ8HB5ZnX9yOq4GKf3fCzp6zxcDkoug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728675254; c=relaxed/simple;
	bh=nTshgEWGQlV/ozPsexbIbTTaFdAHZWMGLP23m169EyU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Fy+IkLqvEo7nrxP/ymF0bAgF+jbymt7pjf2KKvZnHZJ5/IrFOsiIPXk6ZoK9qVN2QiYX0HlY6JTnJOs++x+XPStSfUDMb8uf0zS6f6wAaqGZR4dNDKfqmDPvLHpdXhzlyVVFVWQ+hKs/HrHzHyi8Nh3P2Gh5B0R8NDkTwuQzZbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5r+wo2H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D91EAC4CEC3;
	Fri, 11 Oct 2024 19:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728675253;
	bh=nTshgEWGQlV/ozPsexbIbTTaFdAHZWMGLP23m169EyU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=e5r+wo2HVHC9ZQccju6QYaiHHWEQgRiWlkk8gxDw80AvIaz9bGMJ6l/ehIkU1jE30
	 BujajLpKmS9iaRSaiYQ//bY2YDDjuCAd5+bFg2GUEZOwgsif0EhqtxZCG6wCLDS/Bh
	 jaiMUkng7nyKMrtCZkvHMUNlzOsrZay0p+i53E7mpRinJNlYH+E3jsgMulgHHjVFhz
	 aQta/4Kg8IcZYkazEprO75Mq0ESo8IFhuQZtEI66aKah4Y+H4+/U4e/+iieHrDIPXz
	 /X3fOH3PNuGAs8XSdY6tF6Uu4L3cfWY63Q9RHDr3MssfJZKVeckfw1+V3TLFbjONyL
	 u4SWljc6/XIPw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCFF38363FB;
	Fri, 11 Oct 2024 19:34:19 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fixes for v6.12-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0j9MrSTXS-uZxNy=hfx514QdBCqFQ25tC0nVV-URX2xBQ@mail.gmail.com>
References: <CAJZ5v0j9MrSTXS-uZxNy=hfx514QdBCqFQ25tC0nVV-URX2xBQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0j9MrSTXS-uZxNy=hfx514QdBCqFQ25tC0nVV-URX2xBQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.12-rc3
X-PR-Tracked-Commit-Id: 1af7e441feb08cdaab8f4a320577ed0bba1f5896
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 325354cf00c7031c32618feaadc0f22eadee790c
Message-Id: <172867525824.2975359.6422921440743320653.pr-tracker-bot@kernel.org>
Date: Fri, 11 Oct 2024 19:34:18 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 11 Oct 2024 17:36:39 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.12-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/325354cf00c7031c32618feaadc0f22eadee790c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

