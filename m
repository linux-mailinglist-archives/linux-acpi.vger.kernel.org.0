Return-Path: <linux-acpi+bounces-7549-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5E4950384
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Aug 2024 13:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 646FA283CAF
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Aug 2024 11:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5E1198E61;
	Tue, 13 Aug 2024 11:23:17 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3257C198A20;
	Tue, 13 Aug 2024 11:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723548197; cv=none; b=CcbhBKQPLiCZ8PgTGOkhLxjDA7hOilBLgtxAtgWsDOLvAV7HUnCyqAOzZn+1r7/Z3dF8ja9GoVKFdeNaw7zVSJ5jA4Qnh9kP52huypTRgeiTZ44SMDLmJ8K9yD/u9Ct/+1JuLZeKmSvAmyy06C0H3iZWX8nxfQ3KSFnNIpDJxN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723548197; c=relaxed/simple;
	bh=KOZpQSqsgVYcuJwLsAp0gbER+6u0o7K/YNYiOEXrObY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EC7VCKDPsVidVjEEtVLvp7KUnF2XdpGD6nCsldME1H/Vr7LBeESl01n+RlJHK3hAmovsixoHS/o84XjEaV+Qf2eaII+MrI4L60FchjygAFP+mWvjib0K2o0NMISbIfbkr6T2PNIRMOXQbtskypT5ZPfNrGYesazOgJ57dWCbtLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [10.20.155.173] (guest-wlan-ext.mpip-mainz.mpg.de [194.95.63.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 0770B61E5FE05;
	Tue, 13 Aug 2024 13:22:35 +0200 (CEST)
Message-ID: <04c0b62d-03d7-460a-a4e1-ed8b9b094abe@molgen.mpg.de>
Date: Tue, 13 Aug 2024 13:22:33 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] ACPI: align slab for improved memory performance
To: Colin King <colin.king@intel.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>
References: <20240808222138.51-1-colin.king@intel.com>
 <aaf516f8-eb36-4693-a002-a972d6f77b92@molgen.mpg.de>
 <CY8PR11MB77474CEA74FB6A572D9856D28D862@CY8PR11MB7747.namprd11.prod.outlook.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <CY8PR11MB77474CEA74FB6A572D9856D28D862@CY8PR11MB7747.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Colin,


Am 13.08.24 um 12:17 schrieb King, Colin:

> Thanks for the testing. How many iterations of the test did you do?

Two times.

> I ran mine 100 times with each config to get a reliable set of
> measurements.

What system did you test with? Were the times with the alignment always 
lower?


Kind regards,

Paul

