Return-Path: <linux-acpi+bounces-11778-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA51CA4E114
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 15:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8BDE3AE3E6
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 14:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019ED2417F2;
	Tue,  4 Mar 2025 14:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n5m6E1fg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from beeline1.cc.itu.edu.tr (beeline1.cc.itu.edu.tr [160.75.25.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216CB23DE80
	for <linux-acpi@vger.kernel.org>; Tue,  4 Mar 2025 14:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741098386; cv=pass; b=ajYJWlRS1HVHvq9aRBx/5C9zeVWOjdT0xVdaGzWqOGdlq/YfExgSj9EuxTdph0apE1W2XBOqU1Ye33mQCm9awbw6wZbtqZknbArTg/KuTkkJRQEqGS6Prx2WfYtkS0iTYehOFqv3fcXkip4KBkBtC4YF637Qve4wT09DGkbqZYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741098386; c=relaxed/simple;
	bh=j1ghf+0O9QJ9puRHnNXhg9N1r2ibOt2kzP+sia3x+c0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dhLf/SEOtzdbwirhzQshfhgfPRZH2Jf33XAbXh7e2AaB9srqzYIk8mopTE3pgd18Jp51XocHIBTvqTxH7UimnIoS8kxdEsNaJwIAyNC27sxaBX7CUTf3/1R3AhSJF/nkxOM7nuGBdGV1W3LBV9iLXtbw5KWIY7TEibdVdp+jeeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n5m6E1fg; arc=none smtp.client-ip=198.175.65.9; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; arc=pass smtp.client-ip=160.75.25.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline1.cc.itu.edu.tr (Postfix) with ESMTPS id 5572C40D050F
	for <linux-acpi@vger.kernel.org>; Tue,  4 Mar 2025 17:26:23 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=n5m6E1fg
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6dHW1XDZzFwcD
	for <linux-acpi@vger.kernel.org>; Tue,  4 Mar 2025 17:24:55 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 214AC41898; Tue,  4 Mar 2025 17:24:47 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n5m6E1fg
X-Envelope-From: <linux-kernel+bounces-541699-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n5m6E1fg
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id 0F81A41A6D
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 15:26:33 +0300 (+03)
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by fgw2.itu.edu.tr (Postfix) with SMTP id 4DDC52DCE0
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 15:26:31 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8DCF7A8B4E
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B3D2101AF;
	Mon,  3 Mar 2025 12:24:48 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087CD1F0E2C;
	Mon,  3 Mar 2025 12:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741004685; cv=none; b=WCDRcFTg6zHs8ZEOEE4E0Aq+d/rgSoygZpCJ+mEBpTRi2f9pQlkvEEKihMYCRBviXzDls5rWGbO0klrfsvYgwU+4bDiBrS08X1SR7YiNpKWZ6tUPXiBAzTTb4TnDeRH1MXqZpU9bEb183aLqbRGcq++wPuQoogsFAyyMxh7YlSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741004685; c=relaxed/simple;
	bh=j1ghf+0O9QJ9puRHnNXhg9N1r2ibOt2kzP+sia3x+c0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rNwVUbrKUzrAQv69uAzilwVi+e6fH5ue3uevu8Cw3Qb15rFkvLE1N9Hfu8u6k/+anJcgfUpMi/ZduPXa62TWjWaSs2iJnOxqlMVgGAhUGPlJGaTRqD1LN23he3RolkhvWhZZ0A/PfJdAaepKogDgOPoGmGc4ejPUY61I5i52aSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n5m6E1fg; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741004684; x=1772540684;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j1ghf+0O9QJ9puRHnNXhg9N1r2ibOt2kzP+sia3x+c0=;
  b=n5m6E1fgYJt+8ruOl8Eyr6HGGKlOQXFxUX74N1/PSoPH32uLwauZ9hvK
   NN9rDVakAaWGSIfir2Wl9LEaSqw3c3/RJFK4+fUAmSvPUzXTjUwGYYbWS
   x3itDJVCdOZfbuST95bVR6TDTFWkAr8DG+Yv9g4W+SoNiFY+VjiVC7L04
   tvXUL2Cxn65cYm+X5+Fc3ZC4UZrehzKO7QUWfl1B3g9ChduaS2L7Vi8kh
   8hnzH3ydKxbctsNK9DYUGXLTPgj38GkNFGHZdCeL/OI8PvntZnXenlFfq
   QtCgVFE7Y+hTDEJ4mZc7mCqZDtu5AKZZ4DfmTGomMAwGTNkLUTWXWyDR+
   g==;
X-CSE-ConnectionGUID: 9TOR9/80SJuFyH4xaMIgZw==
X-CSE-MsgGUID: 03Ko57+NRFGwB2TRgvKiVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="64320548"
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="64320548"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 04:24:43 -0800
X-CSE-ConnectionGUID: bQufeDxFQFWMqaTx9aSf+Q==
X-CSE-MsgGUID: in9DvPjwRr+WBjh68L1d5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="123136809"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 04:24:39 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tp4qZ-0000000GoLr-2PU1;
	Mon, 03 Mar 2025 14:24:35 +0200
Date: Mon, 3 Mar 2025 14:24:35 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH RFC net-next v5 10/10] net: gianfar: Use
 device_get_child_node_count_named()
Message-ID: <Z8Wfgx2NjB-_AyR_@smile.fi.intel.com>
References: <cover.1740993491.git.mazziesaccount@gmail.com>
 <685cd1affabe50af45b767eeed9b9002d006b0fd.1740993491.git.mazziesaccount@gmail.com>
 <Z8WXqgxgFQC8b8vC@smile.fi.intel.com>
 <aacffceb-e9e8-412a-a624-568e6b10d586@gmail.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aacffceb-e9e8-412a-a624-568e6b10d586@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6dHW1XDZzFwcD
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741703102.25134@siEJtzlW5guNAMIeGcoqVA
X-ITU-MailScanner-SpamCheck: not spam

On Mon, Mar 03, 2025 at 02:13:30PM +0200, Matti Vaittinen wrote:
> On 03/03/2025 13:51, Andy Shevchenko wrote:
> > On Mon, Mar 03, 2025 at 01:34:49PM +0200, Matti Vaittinen wrote:
> 
> > What about the second loop (in gfar_of_init)?
> > I mean perhaps we want to have fwnode_for_each_named_child_node()
> > and its device variant that may be also reused in the IIO code and here.
> 
> I agree the fwnode_for_each_named_child_node() would be useful. I think I
> said that already during the previous review rounds. There is plenty of code
> which could be converted to use it.


> This, however, is far more than I am willing to do in the context of a
> simple IIO driver addition. The "BD79124 ADC suupport" is already now 10
> patches, 2 of which are directly related to it.

But you already will have at least one user (IIO code) and second as in RFC.
I do not ask you to _add_ patches.

> I propose adding the for_each_named_child_node() as a separate series with
> bunch of users appended. That's be plenty of beans to count for those who
> like following the statistics :)

It would sound like an unneeded churn as we first introduce something that we
already know needs a refactoring.

-- 
With Best Regards,
Andy Shevchenko




