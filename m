Return-Path: <linux-acpi+bounces-19955-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA40CF485D
	for <lists+linux-acpi@lfdr.de>; Mon, 05 Jan 2026 16:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3979730422B3
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Jan 2026 15:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7791832ABF1;
	Mon,  5 Jan 2026 15:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VpHw2weQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51222313551;
	Mon,  5 Jan 2026 15:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767627727; cv=none; b=e/TVxa5tezZhSoe2euJ4Zkg6rH59QqBs15KizMjJg/jMg5ZUM0jY/+HSr1s35jbWgZd7HjHrHOqK+0RQvoHF3ioRPM9S7kNuVhntolgUCuV2qZbd6eZJFEttF/gyQO0CrIYn07BCVDhoiLOp0nyzKsmOLw9LzDBJcoBkOAuqc1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767627727; c=relaxed/simple;
	bh=+0NMOAKUG0dwKWhyMQLKy/r2RKAsH6mrMjG8plHN2To=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RHwhVl+c30ri29UYmHdS1MLE6b5XuaePEbFen0nzzinmgH6wDUWdy8mac4hL93vd2rx4eHCl+txw+qDx7Uya4UO+TspNp00XLygKqp5c+6LW/l1AFQDBqWUHIOm5R5V9laIGXxlxcmF1qqJPVGcodOds7HrZMjbAWiKpk59LYc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VpHw2weQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3208C116D0;
	Mon,  5 Jan 2026 15:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767627724;
	bh=+0NMOAKUG0dwKWhyMQLKy/r2RKAsH6mrMjG8plHN2To=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VpHw2weQFR5E+VhdZHO2MZcDjSsMkQcIMaq1zUde87LdYz1CPBH2xmTYjNdTRRaqg
	 mQG3F0387janOXa+J7orF/Gl7eP8wwimGM3umCTjGLhEErA6O+2aZrWlfBfAZkyazy
	 OSNie2BuZxmLnMu/TJwv7W/iGWaJdFBWoaxixqrJLMjM2YUfnoO8LgbpSfLAFGGB9O
	 s1NTLh+gfR3rTb85ikrVk4u9MgQwuUGyB3n1O+77+K67hGhzcMasNJ4q0mOSun/2Md
	 Gax0GuKEaPg7Gym2S99kMIqSt3OzsFg3CwprsOFcSBVCkR6xWoOtxG5ZkaR+RLyMrF
	 +FSIyxOI4DRsg==
Message-ID: <bd4c4501-7be4-4ca6-ac5c-1998f42fd4a8@kernel.org>
Date: Mon, 5 Jan 2026 16:42:01 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND][PATCH v1 0/3] ACPI: video: Convert ACPI video driver to
 a platform one
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Armin Wolf <w_armin@gmx.de>
References: <12824456.O9o76ZdvQC@rafael.j.wysocki>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <12824456.O9o76ZdvQC@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Rafael,

On 2-Jan-26 12:48, Rafael J. Wysocki wrote:
> Hi All,
> 
> This is a resend of
> 
> https://lore.kernel.org/linux-acpi/8617910.T7Z3S40VBb@rafael.j.wysocki/
> 
> due to the lack of feedback.

Sorry for not being able to provide feedback. I'm still getting
up 2 speed wrt my new position at Qualcomm so atm I don't really
have time to look into this.

I do plan to add linux-pm/linux-next + these patches to my local
kernel so that they get some testing that way. If I hit any issues
I'll let you know.

Regards,

Hans



