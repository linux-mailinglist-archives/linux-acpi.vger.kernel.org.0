Return-Path: <linux-acpi+bounces-15398-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB11B14896
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Jul 2025 08:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E4744E4397
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Jul 2025 06:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4222C25F963;
	Tue, 29 Jul 2025 06:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sA6qrQ7v"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1970225DB1A;
	Tue, 29 Jul 2025 06:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753771787; cv=none; b=UayNLhWht9rLYD9HASV3l05vA7xg7brqXn8BqBLKQgVO7gEKUv1Sz20R5ts9hS+mDM6Y/vrfIVer1Dn/KBo5OKU7YCOUcALXAynEWEZtFaKeonDoB2z8ISX3GOyQCaEneidZve0Qz5GLFe1AX2V+ZND4y2nmqXSKzywu71FC0Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753771787; c=relaxed/simple;
	bh=miQ8jYBxLkuUHgG0k3f0mxUwcsDdpw/tP5vD5qh8KQA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=PUGxoMLuSYInjCIQnfx3xenjAOZvyPo4SUHFe2agNs4IHyTkcNmSeNbCryN8ka6YzXNwL7vI2PaX94jHsXplbWGeCfsCUM02gSSgWV1tI91Ao7moIdj5ifPGq9G/X0qkfdDPSAYl2bgppA01qZfjg6a5u2kI3bLw1asR+g2wY00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sA6qrQ7v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E59BEC4CEF5;
	Tue, 29 Jul 2025 06:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753771787;
	bh=miQ8jYBxLkuUHgG0k3f0mxUwcsDdpw/tP5vD5qh8KQA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=sA6qrQ7veab5qJprKD6DwtH6TqbMXjglU+qYqbEezudORVNYfI6EQDxRDuJBxtOxl
	 fhot9McSGEN9Oiy6HzQfyo0IRzHMg8QMnqgyd2EKVnAPgwWo0EbduoNUzN+5N+eC+z
	 uZN6zdR+wWEy7/KJ1AUFuhZ53O2P6XwlY3BVAXxgj6VEqLDYTPizmm+qUO1osVzKH+
	 ik+ns0OIACbBHAtodJ4wBMJzAqRrOujiQ+J3wEfJRfknyM26vUJ/85Gqx1u9OX7xzr
	 U1eGC3utxo8Gy9Ku1styadkyIggFhHYTciGs5upOW/W5foj59cS5CVaAQm3T219F7d
	 052JFb42XL9Qg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 87D1B383BF60;
	Tue, 29 Jul 2025 06:50:04 +0000 (UTC)
Subject: Re: [GIT PULL] Power management updates for v6.17-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0jRGpZP4DDNVq0+27BmxhahpOHX-kZKGWxwrWy-JwQjHA@mail.gmail.com>
References: <CAJZ5v0jRGpZP4DDNVq0+27BmxhahpOHX-kZKGWxwrWy-JwQjHA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0jRGpZP4DDNVq0+27BmxhahpOHX-kZKGWxwrWy-JwQjHA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.17-rc1
X-PR-Tracked-Commit-Id: 40c28199550d5cdace4583bfe723a7636b170a90
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 53edfecef66bfa65882ae065ed1a52f466c88979
Message-Id: <175377180340.1356386.9139161093172783064.pr-tracker-bot@kernel.org>
Date: Tue, 29 Jul 2025 06:50:03 +0000
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Mario Limonciello <mario.limonciello@amd.com>, "Chanwoo Choi (samsung.com)" <chanwoo@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 24 Jul 2025 14:34:55 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/53edfecef66bfa65882ae065ed1a52f466c88979

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

