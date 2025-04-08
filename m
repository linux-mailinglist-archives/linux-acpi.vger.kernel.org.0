Return-Path: <linux-acpi+bounces-12863-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27FCCA80F93
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Apr 2025 17:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93A61169A59
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Apr 2025 15:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1953222ACF1;
	Tue,  8 Apr 2025 15:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jt1ru2Bz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A6F22ACFB
	for <linux-acpi@vger.kernel.org>; Tue,  8 Apr 2025 15:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744125141; cv=none; b=q712dR2TfGwScEwa6+l+QLEOkFqrMph5Z/c0+txbISeTJnrAKRjjQKm488bIAGTUM2fGRjEbYTfygD+VRSsyjJ25XuEy0kz57iD2CY3aG2Xm04PcHfD7jboGRwSXliQ94HsDARQCYSks5KD1q2h1HnUTD6UP3/0fCQF17xwFZFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744125141; c=relaxed/simple;
	bh=AhRbPW8jizYzfxcFtP9Ab9o1R4iiG4UfQvtkcbitkOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SXMJUktC8vt/l23t1+i9mQzTidyJXJHbbz53GBAFJnui4DImF1Yg1NjOtkQWGdCya8VxRXGsLAdqhMaHuUvAWN6jN7xEqdWu3ogcmR4OeJOIV7Ae76UCnWi8LXD6pJ+728a4qNj3uyId0UXMVXM3f2j/9b0ZNc7HYmkmG8iKsDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jt1ru2Bz; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <52d79db7-f1fa-4695-aeb6-d07d6c2f90dc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744125127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fQDzFs3D8+IKQHpA3NyfYp/CU4mVPF0Wh33CkTrO1is=;
	b=jt1ru2BzEjAWPoNczH0V9smgPKLwAmsttSD53DtCJ23bhyxVZg2k9LmnmKOLNmALUfoIte
	V/dZMOTDrKhdUQfXl3HCP9d8C2lQnrtx3htm9cl1Rdi43cq0kP6TQ6m43JKpTgWuZzGqcK
	of4qJ77QmE0dxpUQGTJEm9ucu72Ueuw=
Date: Tue, 8 Apr 2025 11:12:00 -0400
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] device property: Add
 fwnode_property_get_reference_optional_args
To: Rob Herring <robh@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Len Brown <lenb@kernel.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Daniel Scally <djrscally@gmail.com>, linux-kernel@vger.kernel.org,
 Danilo Krummrich <dakr@kernel.org>, linux-acpi@vger.kernel.org
References: <20250407223714.2287202-1-sean.anderson@linux.dev>
 <20250407223714.2287202-3-sean.anderson@linux.dev>
 <CAL_JsqLQvyBvOXJJhRcnVAVx81MUf9YwtyZ5VC-whwY=uoeDXw@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <CAL_JsqLQvyBvOXJJhRcnVAVx81MUf9YwtyZ5VC-whwY=uoeDXw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 4/8/25 09:00, Rob Herring wrote:
> On Mon, Apr 7, 2025 at 5:37 PM Sean Anderson <sean.anderson@linux.dev> wrote:
>>
>> Add a fwnode variant of of_parse_phandle_with_optional_args to allow
>> nargs_prop to be absent from the referenced node. This improves
>> compatibility for references where the devicetree might not always have
>> nargs_prop.
> 
> Can't we just make fwnode_property_get_reference_args() handle this
> case? Or why is it not just a 1 line wrapper function?

fwnode_property_get_reference_args ignores nargs when nargs_prop is
non-NULL. So all the existing callers just pass 0 to nargs. Rather than
convert them, I chose to add another function with different defaults.
There are only four callers that pass nargs_prop, so I could just as
easily change the callers instead.

--Sean

