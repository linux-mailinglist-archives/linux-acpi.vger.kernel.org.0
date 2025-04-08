Return-Path: <linux-acpi+bounces-12864-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED8AA80F9D
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Apr 2025 17:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D5E8189356C
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Apr 2025 15:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141D220371F;
	Tue,  8 Apr 2025 15:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QBiRp1r0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9271E0DE8
	for <linux-acpi@vger.kernel.org>; Tue,  8 Apr 2025 15:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744125234; cv=none; b=M54/6yy9bSk1yiycNYQQgR80FUKvIC2qTPSanRsAFA4G8nIeNcsOVLB459elMOcrkD4ULCKWuFPhSYVFMuUbbtZ9KlK0XkDKrYJoD1P2dvWU998ztllg0Xz2Qi5XUPfVKFNQl7k3vo6uqXRRe3yYFxMI+/4/Z/uubuz/GD5TytM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744125234; c=relaxed/simple;
	bh=2rGFA1MmKjfyPCb3EVOeMcIHT7xlnr9PJ1OpM+4Wr5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RYdu9lpXxktOabJHz9QzgL1Dhk1TQUJHqkDH7nByL4XzdreqDBKRVq5qohcUfNG5WwIgupyO6rsWyGz3ApflsgpGUiRISvs3IuhlBxpnjdk3l34btz6iDr0i3x9bMLBs2XDYRu3m2lEMZHCZrCnT1zkFb3CfJEVHCD8+hxeG8j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QBiRp1r0; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0b0438af-1cd6-44be-b9fd-1036d579a83d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744125230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jxAkzFNU4ZFiZLFlhzmE+4v2edtj5U1DrVC5Uqoqrg4=;
	b=QBiRp1r0gx/UHcommsD9xTSt+IdLfDdDMb22Hr3nAvmV0NV/Lf+LAxkxsyE8UMCEYETqFl
	U4T2bX9TNV8IZQyuiW3ek9BvdB9+X9k6mcJnXKg8eqlzLvFq2T/5FWgImbQfaQWP6qpIkx
	nRytRgT+1Ue9J9dW0+i/czzLTzxbfto=
Date: Tue, 8 Apr 2025 11:13:44 -0400
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/2] device property: Add
 fwnode_property_get_reference_optional_args
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
 devicetree@vger.kernel.org, Sakari Ailus <sakari.ailus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Daniel Scally <djrscally@gmail.com>, linux-kernel@vger.kernel.org,
 Danilo Krummrich <dakr@kernel.org>, linux-acpi@vger.kernel.org
References: <20250407223714.2287202-1-sean.anderson@linux.dev>
 <Z_Tg9JIP7iSoTujj@smile.fi.intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <Z_Tg9JIP7iSoTujj@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/8/25 04:40, Andy Shevchenko wrote:
> On Mon, Apr 07, 2025 at 06:37:12PM -0400, Sean Anderson wrote:
>> This series adds a fwnode-equivalent to of_parse_phandle_with_optional_args.
> 
> Thanks, but no user. Not acceptable in this form. Also see individual comments.
> 

https://lore.kernel.org/netdev/20250407231746.2316518-1-sean.anderson@linux.dev/

I was hoping to get these patches reviewed/applied separately, since netdev has
a limit on series length and these patches push that series over.

--Sean

