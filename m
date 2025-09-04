Return-Path: <linux-acpi+bounces-16383-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0F0B44639
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Sep 2025 21:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDBC5176EAB
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Sep 2025 19:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00AAD2505A5;
	Thu,  4 Sep 2025 19:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="KiAdctAj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from fossa.ash.relay.mailchannels.net (fossa.ash.relay.mailchannels.net [23.83.222.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37321D6DA9;
	Thu,  4 Sep 2025 19:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.222.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757013356; cv=pass; b=uPvt09tbmNyKyrrBzcABxlhnLSbDTaeZgZay28Fr49268DDBtQJasYq9YXWWSBXnFaVNc9X1A2gyUXimkr2oJDMGJsvSdVEE9zieexD3ZJSuXELZ2O7UUDJAUWF//c9Y0HLlsoqXgXSu7Qy1auCMTmZDy21OVGbF8+/+vPYi6hc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757013356; c=relaxed/simple;
	bh=wzEL6NG8otzv6w22FIroHhxlJ82Wd23EcDr+/drdg2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JDgtsq6sfBK4+lTFrBdZntOGOZt4zkhh65j6IHoL9Z/7Vyx+ZYIcg/9a8rrR4iqqsZ1ArmLWkBbYiWBaf+yG1ZXSodxleUdmoTYLRpO3vOcYuEJVdifN6GoIEFjgXsy/W5DqUpE+ouKHovYqAPdap52nXU2CqrbDlvGNye8nMTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=KiAdctAj; arc=pass smtp.client-ip=23.83.222.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 4044C4E2BFC;
	Thu,  4 Sep 2025 19:15:44 +0000 (UTC)
Received: from pdx1-sub0-mail-a216.dreamhost.com (100-103-70-103.trex-nlb.outbound.svc.cluster.local [100.103.70.103])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id C78F54E6CDA;
	Thu,  4 Sep 2025 19:15:43 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1757013343; a=rsa-sha256;
	cv=none;
	b=dC5Ah8QIgHBYCaFkm6ofG0RbEm330ydIucQBKYaTBo8xaGocko7IAgHW6aKKU+vHe/7RC7
	eYP6Kl0rCAI8Lknq59WZmVhOYV2JSEPzlQGigmVfM+kJPobrfH1osPWIIW5DGfdIH0lG0j
	ZWOSOPFsEXdEexrn/bVZyaNaPy2a4KtdRtl80hZ1E7wivLYbrx2iDvNuF2bQiZ46REvFjn
	cZKeOnTa77sCxVsYKsItUOAKCCAn6esd6n4bKYHMTDQFNdnjCqthzLeoYS+2SRwMZzAlOw
	xJ11aAjkC4WMTAwuyVBQSmhFaLt8bRhP/HN4XZo/loUs6qDYfRs6m3bBFHgvvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1757013343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=wzEL6NG8otzv6w22FIroHhxlJ82Wd23EcDr+/drdg2s=;
	b=3xMsy+wI0wXeVgO0FejtOdaonRP6VIZoY3uuehCtqztmLvml4SbPnExQROeEWyWKUBm8mU
	ekk1F+IxbLaJFa2DnhJh9Co//NryeGKd9lsqon9yR6pDbOYUffN2oY8U3ZeE/QxX42eLXo
	kkVTKYcxMowwZbrKC4/nDmQe1Vxlwa5uxVtVs/hQRsaQlwYbMn2wZVGygtuE5MPNta0oV2
	Cuii8kex1Ivaz3xyC8zZkikx3UngEdDllFCeaXdTp14hXN+AuJb+8LAffCV93byvBZZ6qz
	L3L0wbVB74bbt6KuxZivfVQXPlUDcjYA7NkHqG+vSzKKe+l6cQXhS1lQZGi0wA==
ARC-Authentication-Results: i=1;
	rspamd-c79647f57-75mrv;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Tasty-Imminent: 3f45dc202bef1583_1757013344101_1843994034
X-MC-Loop-Signature: 1757013344101:3850763103
X-MC-Ingress-Time: 1757013344101
Received: from pdx1-sub0-mail-a216.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.103.70.103 (trex/7.1.3);
	Thu, 04 Sep 2025 19:15:44 +0000
Received: from offworld (syn-076-167-199-067.res.spectrum.com [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a216.dreamhost.com (Postfix) with ESMTPSA id 4cHq266dV7z6b;
	Thu,  4 Sep 2025 12:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1757013343;
	bh=wzEL6NG8otzv6w22FIroHhxlJ82Wd23EcDr+/drdg2s=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=KiAdctAj2riQ+aPH9sJRjoDoEbcvYiTxguFMBBf/zNiuGnvlgTXNarq5Qf5cM+HwY
	 02utt3nMGsdCQiPuXUcrn8e1AyEqI/4wcRRNOawXvsWpLTPknjFGbz0GaI1XrrcoUL
	 j5GyFO+4M9NkN8cUrDChDL1w79JTf6yRtzjAGV6KH+D8rJ0fTLl3BR/6oNtwze8TNN
	 PBKt9HsY5I2pP8Bswz0jLf4qAQyyAjkyOAB6vbMzhUv1xsuOjQZ6Cd85gHl+s3S6Pe
	 rhaD7LkBK7l3kkiIxLHEqcrnuxK5IoTzN3ADX0Ix09ZAcHqiwK3h0pZRLa+nIxbk/S
	 4GbZviPUVn3dg==
Date: Thu, 4 Sep 2025 12:15:40 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: rafael.j.wysocki@intel.com, dave.jiang@intel.com,
	dan.j.williams@intel.com, jonathan.cameron@huawei.com,
	alejandro.lucero-palau@amd.com, ira.weiny@intel.com,
	alison.schofield@intel.com, a.manzanares@samsung.com,
	linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] acpi, tables: Rename coherency CFMW restrictions
Message-ID: <20250904191540.rb2dn4frng2ruq76@offworld>
References: <20250904184801.47498-1-dave@stgolabs.net>
 <CAJZ5v0j9r6bKOXuo+o0gdhryR1ne3WY3B0o0DufEHB9y3j0Leg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAJZ5v0j9r6bKOXuo+o0gdhryR1ne3WY3B0o0DufEHB9y3j0Leg@mail.gmail.com>
User-Agent: NeoMutt/20220429

On Thu, 04 Sep 2025, Rafael J. Wysocki wrote:

>On Thu, Sep 4, 2025 at 8:48???PM Davidlohr Bueso <dave@stgolabs.net> wrote:
>>
>> ACPICA commit 710745713ad3a2543dbfb70e84764f31f0e46bdc
>>
>> This has been renamed in more recent CXL specs, as
>> type3 (memory expanders) can also use HDM-DB for
>> device coherent memory.
>>
>> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
>
>A link to the corresponding upstream commit, please?

https://github.com/acpica/acpica/commit/710745713ad3a2543dbfb70e84764f31f0e46bdc

Thanks,
Davidlohr

