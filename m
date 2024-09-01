Return-Path: <linux-acpi+bounces-8057-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B5B9675D1
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Sep 2024 11:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 739591C20F51
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Sep 2024 09:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA205142904;
	Sun,  1 Sep 2024 09:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="YF1y0TPA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE750144D1A
	for <linux-acpi@vger.kernel.org>; Sun,  1 Sep 2024 09:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725184004; cv=none; b=fqVU5n+8Eqp5QQUJ49sMGUpVqEWKdnh44kpSFCh7ZqgglVtbOB2j+/ObI/s+PRgdyhR3u5v8Ep99g62wBcKlKHG1VUf99EoPd9c9FnmHiqBK7M2UX49EdW8KkxUqH8fDLnxpdJTfnEJ7HZALN02TXVCNbTkS1NIvhsIs0rXpUQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725184004; c=relaxed/simple;
	bh=9FocW7zjexnKq4T+vWzhB9rlYFILanSMQDUjLMtZ2sc=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=XyMB3ipGgTaGvCvV9DpskHaizg3FMmoSrukuMzW3i7Uz+uVovvJAXaU7hZVjewzDaM0LM+PlgJB0EFUg+/CR+uh/SkYtNXArNRegdN6iH5d3gTzwoWPavsDaM9i+N7mWurKm49bT+Up6rYP8TRR8OLyOtcpRTzANjMSYjPjZ1Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=YF1y0TPA; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:Subject
	:Cc:To:From:MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=9FocW7zjexnKq4T+vWzhB9rlYFILanSMQDUjLMtZ2sc=; t=1725184002; x=1725616002;
	 b=YF1y0TPA7PdiGJvCi14F0LMxiYc3M8hkp9TNY2jYXgkrx8C0err2NZMpMz9kYdkjfs3JGbtWLg
	m0WYWtYbomBVJM86uD7CpF9vamL65GjLpt+p+AF3aS+epgD5mZV27SEwpTfGxvWmaJgqkEvF+DVWu
	UU2WbseVy19LLuhaqPiOsv6Ok6NFyERUN/FJi+6WY3pXbbe9qKNU87vhon0ZMLqgW5KQVI+W5t4Mw
	P4FIX3rGDsRb3slrjWd63NgAXDCVI/WKOF6WiZ11tuk5m+8lzCODGGBd+6WJhKJsKImG6af9RLFqc
	CFDogcAjl/W8jRDkPvulZ1s9zLQwL8uW9uNEw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1skhAI-0001Qy-Vo; Sun, 01 Sep 2024 11:46:35 +0200
Message-ID: <8bb913bc-678e-4716-bea2-64e5ddd38b64@leemhuis.info>
Date: Sun, 1 Sep 2024 11:46:34 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: en-US, de-DE
To: Tamim Khan <tamim@fusetak.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: ASUS Vivobook Go E1404GAB_E1404GA keyboard does not work
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1725184002;3002c43e;
X-HE-SMSGID: 1skhAI-0001Qy-Vo

Tamim Khan, while monitoring new bugzilla tickets for regressions
reports I noticed a non-regression report from someone asking for a
quirk entry to get the keyboard of an Asus machine working:

https://bugzilla.kernel.org/show_bug.cgi?id=219212

I noticed you submitted a few of such quirk additions lately, so I
thought I let you know of it. If you don't care, please just ignore this
mail. Ciao, Thorsten

