Return-Path: <linux-acpi+bounces-11804-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECD0A4E93D
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 18:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D404C1882962
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 17:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C44C28FFC9;
	Tue,  4 Mar 2025 17:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c+O8bjEl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2515728F93E
	for <linux-acpi@vger.kernel.org>; Tue,  4 Mar 2025 17:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741107945; cv=pass; b=YymjUeQs+wAMlD+d39AbuGPX2ZP8qS1ynZMsjO0J+kZzJMOJoC76jWwNeTEbQ8mtY1TNm4u3IZ/D/QoYD4cgKj3y82I0a01CYXR0JrjTiMlwE7R33VRNfEewR6ERFw2mythQa0CbZ0wfX9kOVClTaj3fYl5lVDxd2Xot15PHonI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741107945; c=relaxed/simple;
	bh=WqIKezHZkO7ZmKx+327v0on4OgffbWwg65hwUsgf0aA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pWx2oaI6gU6+ZUTnygH1I0EyqCPPU/UT0ir/M29tAf4rjEb4rCFs2+xu7aVc4mb04b3QSs/+s0uOqY97sNT4Mkeb+Oxf5aOw2EaZNSWLLBF2rf7wW6ZKe7pom4iIyXD/Qx7O7sCCDTT9b64eNkER2xx6Z5EjdGBLooSXbmF7nNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c+O8bjEl; arc=none smtp.client-ip=192.198.163.14; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; arc=pass smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id 942BC40D1F47
	for <linux-acpi@vger.kernel.org>; Tue,  4 Mar 2025 20:05:39 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=c+O8bjEl
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6dRx4Vz5zFwYV
	for <linux-acpi@vger.kernel.org>; Tue,  4 Mar 2025 17:32:13 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 6890B42750; Tue,  4 Mar 2025 17:31:54 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c+O8bjEl
X-Envelope-From: <linux-kernel+bounces-541635-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c+O8bjEl
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 1B0D142B80
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:52:35 +0300 (+03)
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by fgw1.itu.edu.tr (Postfix) with SMTP id BE44D3063EFC
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:52:34 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D87C168245
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 11:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D4A20D509;
	Mon,  3 Mar 2025 11:51:18 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3859204F6B;
	Mon,  3 Mar 2025 11:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741002676; cv=none; b=uPm7dUoOsTh0gV0Rvd2N8deaMCrnz9qLXJsUC3//yudLfhuMIBWpbVw81lZnNWT0P7MKpBZAWT56B9+/jCE1zKvTwhRlmondxL+k+1Q7Xj4PXqtFzd4Gl1YMDkBAbI6EAYeahM6fyxCuLqJQoCd/YM1BM4NL40IuuA2bXnAo/gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741002676; c=relaxed/simple;
	bh=WqIKezHZkO7ZmKx+327v0on4OgffbWwg65hwUsgf0aA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N5Msm04zowrOeZDtvkpYV1tqVnzAWaaz4ilrPr8zH7IwKlIuo79NEwsF/JSMq+5H7H3IxSY8WMpzlIMOS83O1A7SXhnQa+CGCNcO9WN2rBdB/WhDALP9RrIcge5XTJyP+FlkV7kcpiaKlCc/C1QCzc6emm1nEPpLheYMEFzRCn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c+O8bjEl; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741002675; x=1772538675;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WqIKezHZkO7ZmKx+327v0on4OgffbWwg65hwUsgf0aA=;
  b=c+O8bjElb4Tb7fB3QkYCNX72101N28LUT/v0nuwnbsBBRhIHfTDd5zr1
   VEwaEwN16IKd2UlFenQfG1EIBwgMc1ACNAIO+iNacmQeEuCuInk7LSAai
   v2JJOBKLaf1uwmiPd0IsOXoVJM/1uJTDBuiO1gzpvUsZjk8e/mSx03qVa
   pp54hguPOYYbJLQA8R4Hd8RIxmoxhdKfNvmOSLAvIZ6x7cYL5EiSSZJoQ
   4Gv5fIZRF4biPONCXX0lKKHb0Mk48OW93XETrh3AdsphHq3UygXiFz0V2
   d9thTqOLbOeWJNDcQXbLA3qCg/l36oXSkloD1mIu33lhXCTwarN3pty4c
   Q==;
X-CSE-ConnectionGUID: QQo5mCAKSEiw4E8sZ5yw3w==
X-CSE-MsgGUID: FXHbyWANTyKqHybRDutf3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11361"; a="42127243"
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="42127243"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 03:51:15 -0800
X-CSE-ConnectionGUID: 3bwOHvTFSnOvwh1JtWxJ8g==
X-CSE-MsgGUID: EXDMC/eNTIm1xNQT/GlyKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="118021008"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 03:51:10 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tp4KA-0000000Gnqn-1q5u;
	Mon, 03 Mar 2025 13:51:06 +0200
Date: Mon, 3 Mar 2025 13:51:06 +0200
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
Message-ID: <Z8WXqgxgFQC8b8vC@smile.fi.intel.com>
References: <cover.1740993491.git.mazziesaccount@gmail.com>
 <685cd1affabe50af45b767eeed9b9002d006b0fd.1740993491.git.mazziesaccount@gmail.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <685cd1affabe50af45b767eeed9b9002d006b0fd.1740993491.git.mazziesaccount@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6dRx4Vz5zFwYV
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741712611.48081@Sd7AZED8K9GYX1yPmscXMw
X-ITU-MailScanner-SpamCheck: not spam

On Mon, Mar 03, 2025 at 01:34:49PM +0200, Matti Vaittinen wrote:
> We can avoid open-coding the loop construct which counts firmware child
> nodes with a specific name by using the newly added
> device_get_child_node_count_named().
> 
> The gianfar driver has such open-coded loop. Replace it with the
> device_get_child_node_count_named().

...

> It's fair to tell the pros and cons of this patch.
> The simplification is there, but it's not a big one. It comes with a cost
> of getting the property.h included in this driver which currently uses
> exclusively the of_* APIs.

I think it's a good step to the right direction. We might convert the rest
(at least I don't see much impediments while briefly looking into the code).

...

What about the second loop (in gfar_of_init)?
I mean perhaps we want to have fwnode_for_each_named_child_node()
and its device variant that may be also reused in the IIO code and here.

-- 
With Best Regards,
Andy Shevchenko




