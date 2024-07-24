Return-Path: <linux-acpi+bounces-7044-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC0F93AF58
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Jul 2024 11:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BAE71F22FDB
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Jul 2024 09:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E1214EC7F;
	Wed, 24 Jul 2024 09:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="ScMM3yCb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B912152787;
	Wed, 24 Jul 2024 09:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721814540; cv=none; b=ao9MCjWmmubZrH2x5jLWS2JvxGmuwF/xFmSzDA5RC73CYap60HsD3/q96rYYjlEsspRke4ghZ38nHjMphuyv3tMuVa5d0ioRe0EJwDrueTjH4LCWXHpzgsA0Ss/VTVCpzvNWpR11MKW2AR/xZ8RKfb3QRPg+gZlL5KqI2AEbJSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721814540; c=relaxed/simple;
	bh=hr5t1jxhQpxDUa/kqmRw/ckmeINvL3jsJ9Xn4zbAPrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=bTTy67zSDapo9cTVkYuzjCBm+J995oCsAqMDiPhNXexGMJWLK6PM9aXTj6DkTL2uTNchWLvKktG/x+eS/I8I5BxH41rZPCyu+WitHl0nqFLKBvZX/qOaEqXcAhQm7SuovvfuJ4Al9Vzy8z/RanTotue/LwL8UDhYXxmxpYBlzF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=ScMM3yCb; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:Cc:From:References:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=A5IR7bUrgPRi6UY+iawNpG8X/Zh7ZD4sw1KQ94n9lG8=;
	t=1721814538; x=1722246538; b=ScMM3yCbJHDOaMLpyD4hMhwtAL31LyOkkueVfOD03btV3NM
	sZ/bhzKkYiGFuHP7CruALzyIX/gzkeba8RWo2mAw+5MDtctV0DapS2IIsEi7xymkSlsj4V5E70hHC
	dkHgs4FUlueDiIoGPJHUMTIbK7D2AEl0fI1K9Y1Re2mcgmnvMFkIAysc4F/sbIpR/DJB7p+mO5qXp
	uWkx0sS486p7KLXtpu3IoM9LMdwxZjQXyNGw4qVGdfh/mYgLPKi1eUsGqQ2xjJNHqUb6s8ObTCQ9U
	1WanmbMAupXv3rZvmxO/IbBvTYH0nVR/WaIBBSbvrR/YiWGEE+eNyj5WuXUhlmyA==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sWYcC-0000l7-64; Wed, 24 Jul 2024 11:48:56 +0200
Message-ID: <820130ae-2473-4282-9be1-9f3aab1434f0@leemhuis.info>
Date: Wed, 24 Jul 2024 11:48:55 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug][Regression] non-stop ACPI ([\_SB.PC00.LPCB.HEC.TSR1]) and
 thermal zone error
To: Tom Yan <tom.ty89@gmail.com>, linux-acpi@vger.kernel.org
References: <CAGnHSE=RyPK++UG0-wAtVKgeJxe0uzFYgLxm+RUOKKoQquW=Ow@mail.gmail.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux kernel regressions list <regressions@lists.linux.dev>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <CAGnHSE=RyPK++UG0-wAtVKgeJxe0uzFYgLxm+RUOKKoQquW=Ow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1721814538;ad55500a;
X-HE-SMSGID: 1sWYcC-0000l7-64



On 24.07.24 07:42, Tom Yan wrote:
> Up til 6.9.10, I would see these errors every boot *twice*:
> 
> ACPI BIOS Error (bug): Could not resolve symbol
> [\_SB.PC00.LPCB.HEC.TSR1], AE_NOT_FOUND (20230628/psargs-330)
> ACPI Error: Aborting method \_SB.PC00.LPCB.H_EC.SEN1._TMP due to
> previous error (AE_NOT_FOUND) (20230628/psparse-529)
> 
> (they do get occasionally repeated again)
> 
> and these *once*:
> 
> thermal thermal_zone2: failed to read out thermal zone (-5)
> thermal thermal_zone7: failed to read out thermal zone (-61)
> 
> But since the distro I use (Arch) has moved on to 6.10, these are
> spammed *non-stop*:
> 
> ACPI BIOS Error (bug): Could not resolve symbol
> [\_SB.PC00.LPCB.HEC.TSR1], AE_NOT_FOUND (20240322/psargs-330)
> ACPI Error: Aborting method \_SB.PC00.LPCB.H_EC.SEN1._TMP due to
> previous error (AE_NOT_FOUND) (20240322/psparse-529)
> thermal thermal_zone1: failed to read out thermal zone (-5)
> 
> in the frequency of *three to four times per second*.
> 
> For the record, this is now consecutively repeated 5 times every boot as well:
> 
> thermal thermal_zone7: failed to read out thermal zone (-61)
> 
> But at least this one would stop.

I suspect this will be fixed by "thermal: core: Allow thermal zones to
tell the core to ignore them" which is heading towards mainline currently:
https://lore.kernel.org/all/4950004.31r3eYUQgx@rjwysocki.net/

CCing Rafael, who authored that change.

Ciao, Thorsten

