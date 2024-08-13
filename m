Return-Path: <linux-acpi+bounces-7551-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 663DD9504D4
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Aug 2024 14:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23E1C282B07
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Aug 2024 12:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8619A1990AD;
	Tue, 13 Aug 2024 12:22:15 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A34F1CF9A;
	Tue, 13 Aug 2024 12:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723551735; cv=none; b=W7KjnywGpWKYFJUFjPiOCXaZUpDLNofUDcUI9jkj1SJqoIbGYcfzjnlYU7WavOe+qUx90BrSNRccQCCFiW3UlKLE3sZvQgiREoEpAA55SSpWljElAqoltepJNuCnlnsaCsiRQOTswWbOzuJvADhbvsuDi9vOwx0AtM3uYGk5v9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723551735; c=relaxed/simple;
	bh=h8SvCfkejEVckScQQ0iqWWUTrWRCikF2PkqQwvXdm/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AjfxecDjVikBXw9Bbz0EJJz/7MWgB1fv9Q92RRrM0d0AswcU9N55Ntndb8V3h4cDA7YfYIg3NHL6hK5H1V4LgIuAxzngM20/1QGwGIzELxcB5Gsds5sXVjOQ3tMlFsv4UMrIssREAHNDtJyWJuqy9SDDPF6T9mpHX4UV3SqETMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [10.20.155.173] (guest-wlan-ext.mpip-mainz.mpg.de [194.95.63.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 8F94261E5FE05;
	Tue, 13 Aug 2024 14:21:42 +0200 (CEST)
Message-ID: <d406c8ac-9865-4b92-9a0e-cdc3e74f26da@molgen.mpg.de>
Date: Tue, 13 Aug 2024 14:21:41 +0200
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
 <04c0b62d-03d7-460a-a4e1-ed8b9b094abe@molgen.mpg.de>
 <CY8PR11MB7747089744F68731C92A45188D862@CY8PR11MB7747.namprd11.prod.outlook.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <CY8PR11MB7747089744F68731C92A45188D862@CY8PR11MB7747.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Colin,


Am 13.08.24 um 13:31 schrieb King, Colin:

> Tested on a i9-12900 desktop, AMI A.92 BIOS, Micro-Star MS-7D25
> system board, 32GB ram, PCI-e SSD and UEFI boot. Results were a
> derived from a mean of the 100 runs.
Do you have a script, I could use?

Could you test with QEMU?


Kind regards,

Paul

