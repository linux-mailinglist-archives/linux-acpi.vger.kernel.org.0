Return-Path: <linux-acpi+bounces-10201-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED419F85C7
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Dec 2024 21:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E75A1882DDC
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Dec 2024 20:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7BF1EE7D8;
	Thu, 19 Dec 2024 20:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K1Gmf1Xv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E791C3039;
	Thu, 19 Dec 2024 20:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734639477; cv=none; b=I2G73OL/jacR62Uxur7/UzjHfz8MRh5Pcq8JP9WhzfW9qgO2acbirItxw5u24h5/4YjGQWFkzZoqtwTO8xszQoSHQd/30sy9noe9dRig/XiQGouo3zpPbrqXf/g1/0vl+7q9Hou2ieohrrel+I+R6pjs+y8o7xHWxKD1Yg7KfMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734639477; c=relaxed/simple;
	bh=yFBljkSZiR0XACKS9ShYuBxRntYTHS5J3L5mAtaGNU4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=CCHAilMhfBLyJEUMzX+TLCVkbkBjY1nVbAbjwuBUjJn8R+nvQz4sCqKgwVlwgsyM9hb3a3evORjkW/ryERUrrkoybDq90Z5UelA7+oGVnUQJDpEagRGSh2qStE19KWX0V43sp0KCqInsN73bzS4FO3xDjAqTDO40h9PAjjq/1jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K1Gmf1Xv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E53D9C4CED4;
	Thu, 19 Dec 2024 20:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734639476;
	bh=yFBljkSZiR0XACKS9ShYuBxRntYTHS5J3L5mAtaGNU4=;
	h=From:Date:Subject:To:Cc:From;
	b=K1Gmf1Xvb8m66ZKb0za8MY5SezTMz6mmxey/k4Bm88Ex4HRYJ0/8rbjnHkVdHzOZE
	 Pc7ynTtR3PErIS5Nd/7Qp8kuPS4cfmvNh58LVQa36UQr8n5SlSXKm18I+6b/mNHvmE
	 26lFkFS12in+qTKrpit7CICO21Go7XT9y9qbPdwBkKEYFmGRQnslyVu6WgFs17cEuK
	 85fnG/YIitobothZZpcjspS4xrQruI92SQzAaeLuIDaX7Amy79Q+kvE1JgxyAra/f4
	 zVjOWc37o0hg5IkW2XxE4QedqDhh6mFqDaoJ3+zEsYafFPE63TkoGu26J+TaIiyR2a
	 E8kk9tiFRs3rg==
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3eb87127854so352580b6e.2;
        Thu, 19 Dec 2024 12:17:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVvfp4P06ll8VRkSMRL5LO9jxXcucUIx6qvHm4L+A2MLiN+NqNkAIX+BKyVUBescPfHK0TRzKEJYFth@vger.kernel.org
X-Gm-Message-State: AOJu0YxMaiDJSd3XJ+T3sq1pPsH1dH6BR5D+MorPtyK5XW9EM5FRYUWV
	d/Dzr0CVjhTrJ4uYGWSU00ptnkUXjf+o59cjLhvY+VC/SYJ48uSJv61qZCBswt2uhmLD0LL3uY0
	3HAS7kBHT8B/2W2Sg+8NC8TuCAL4=
X-Google-Smtp-Source: AGHT+IFLFN3RREzGy6iMYmD6T700suBPSJEy/n9yT0jq8nYwkTUxLrPWYHf5L3fNSb0un78iG0HPFONXqmrP5A2GGkE=
X-Received: by 2002:a05:6808:150f:b0:3e9:174c:4868 with SMTP id
 5614622812f47-3ed88f4a57dmr84471b6e.11.1734639476233; Thu, 19 Dec 2024
 12:17:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 19 Dec 2024 21:17:45 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gR=fyw2AC=ts5rhCJWWVVQp4cwvg8qrcP2EqXpm6X=-w@mail.gmail.com>
Message-ID: <CAJZ5v0gR=fyw2AC=ts5rhCJWWVVQp4cwvg8qrcP2EqXpm6X=-w@mail.gmail.com>
Subject: [OT][Notice] I will be mostly offline for the next two weeks
To: Linux PM <linux-pm@vger.kernel.org>, 
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Mario Limonciello <mario.limonciello@amd.com>, 
	Shuah Khan <shuah@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Zhang, Rui" <rui.zhang@intel.com>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Hi All,

As per the subject and actually starting tomorrow, through Jan 6, 2025.

While I'm planning to read email occasionally during that time, I may
not have enough time to respond to it, so responses may be delayed
quite a bit.

I am also not planning to apply any patches and merge or send any pull
requests except for a few fixes pull requests for 6.13-rc4 that are
going to be sent tomorrow.

Enjoy the last two weeks of the year 2024, whatever you're going to do
then, and all the best in 2025 to everyone!

Cheers, Rafael

