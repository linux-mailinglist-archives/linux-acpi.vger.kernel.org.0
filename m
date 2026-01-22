Return-Path: <linux-acpi+bounces-20506-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHU0LynncWkONAAAu9opvQ
	(envelope-from <linux-acpi+bounces-20506-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 10:00:25 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE0363AE3
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 10:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ED8F55E284F
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 08:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB813E8C7C;
	Thu, 22 Jan 2026 08:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E7E5MQUA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BF03C1986;
	Thu, 22 Jan 2026 08:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769071915; cv=none; b=nvPWj3CYm0BUVih5HTpscpSJXUhngGfByctubHrVfZ8Y4AHkcbj1+sXoLCT0FKK4fy6FkC/lTcZOeyZJsZLQwL/8sLkb9GZl/QpzgiYY823vYdLHazOPKKFNPX0fFAfKCpe3Xax9o/Y947ds0Ix9p2UZBPR5eZFEpoPhCRc8Uvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769071915; c=relaxed/simple;
	bh=Z1BPPqPX3pPbBMPk0JKd8AgqIRbd45v5OCLMXlCvDmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TWspjDnk60CBP5jG1y4mHpmxTECn3mpXTlBeh901k3LIJWe3fuLYdwKQQ1mB2elTKBy0ri0BHRhkt3bw/CE0bKgLnxSIavDjOPbaPSJVkY+vww/w1uOg9DqXw53t7ksBHzfRovMyDkeKy6eLlTnYLfLGSEp9hGiHFIO0RzHBRQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E7E5MQUA; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769071913; x=1800607913;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z1BPPqPX3pPbBMPk0JKd8AgqIRbd45v5OCLMXlCvDmI=;
  b=E7E5MQUA86S2kVqhNNBjhls97COoh4iDg41WpWIUvxZ3zlfilzZMNmtG
   uqPMBjiAXQqNA8ajbFVXlq1HxI6gZ3KX4BXMgX2yoiyEMV9hahOEoOvOg
   qB72TC0BFoshZpC+L/Y8TQyKmW+W5HQIgQAZ19HHRj0GB9DJ6KFRnft3s
   J6W6vL8zo2KHxA+UiZagjRF0LlFuAqpmwri5/kjBD70sI1jJ+IsXJKhR7
   LYOQrbKMwoB6PUpYIJ8x+PKBKusljKxX7VbLt6tHfUU7gF1dm7VFSItP4
   0A2YlzlhcpUe6Hvp2PZXLzNRfVvzpxZ+Fp0tKZ7rcJc8XozuLMEidBc4s
   w==;
X-CSE-ConnectionGUID: Kzuh9nCeQWO3ObbJjCDniQ==
X-CSE-MsgGUID: TEjq8q/JTVaSGN/gGfWPFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="87886583"
X-IronPort-AV: E=Sophos;i="6.21,245,1763452800"; 
   d="scan'208";a="87886583"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 00:51:52 -0800
X-CSE-ConnectionGUID: Ut8v1+UKSXefrKbRvupFww==
X-CSE-MsgGUID: Fmn0XlYCQ9Ow5Wf/9VG+3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,245,1763452800"; 
   d="scan'208";a="211130999"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2026 00:51:45 -0800
Date: Thu, 22 Jan 2026 10:51:43 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: manivannan.sadhasivam@oss.qualcomm.com, Rob Herring <robh@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, linux-pm@vger.kernel.org,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3 03/14] software node: Implement device_get_match_data
 fwnode callback
Message-ID: <aXHlHyba_kkqnQPP@smile.fi.intel.com>
References: <20260110-pci-m2-e-v3-0-4faee7d0d5ae@oss.qualcomm.com>
 <20260110-pci-m2-e-v3-3-4faee7d0d5ae@oss.qualcomm.com>
 <aWSpFk9z0zpyKjr6@smile.fi.intel.com>
 <26a001c3-2140-4241-87dd-604eab3f827b@linux.dev>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26a001c3-2140-4241-87dd-604eab3f827b@linux.dev>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,kernel.org,linuxfoundation.org,linux.dev,linux.intel.com,squebb.ca,gmail.com,holtmann.org,bgdev.pl,vger.kernel.org,linaro.org];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	TAGGED_FROM(0.00)[bounces-20506-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-acpi,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,intel.com:dkim,smile.fi.intel.com:mid]
X-Rspamd-Queue-Id: ABE0363AE3
X-Rspamd-Action: no action

On Wed, Jan 14, 2026 at 11:21:59AM +0800, Sui Jingfeng wrote:
> On 2026/1/12 15:56, Andy Shevchenko wrote:
> > On Sat, Jan 10, 2026 at 12:26:21PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > > Because the software node backend of the fwnode API framework lacks an
> > > implementation for the .device_get_match_data function callback.
> > Maybe this is done on purpose.
> 
> It is a *fact* that the broken swnode lacks an implementation for the .device_get_match_data stub.

No need to re-create board files when it's not needed or doesn't fit.

> Otherwise, If it is really done *on purpose*, the maintainers of swnode
> backend could/shall document it in the source file *explicitly*.

Probably it should be spoken in a better way.

> > Have you thought about this aspect?
> 
> If you are sure, then stop telling us something start with "Maybe ..."

I wasn't the author of the swnode idea I can't read their minds. Please,
ask the respective people about this directly.

> > > This makes it difficult to use(and/or test) a few drivers that originates
> > > from DT world on the non-DT platform.
> > How difficult?
> 
> The emphasis isn't on the 'difficult', it means that not convenient
> 
> > DSA implementation went to the way of taking DT overlay
> > approach.
> 
> Software node can do the same implementation just as what ACPI fwnode backend does.
> 
> > Why that one can't be applied here?
> 
> DT overlay requires the OS distribution(such as ubuntu) has theDT overlay
> config option selected.  this is introduce extra overhead/side effects on the
> non-DT systems.

If we have hotpluggable or runtime reconfigurable devices this is the expected
option to support them. I don't see a problem here.

> > > Implement the .device_get_match_data fwnode callback, which helps to keep
> > > the three backends of the fwnode API aligned as much as possible. This is
> > > also a fundamental step to make a few drivers OF-independent truely
> > > possible.
> > > 
> > > Device drivers or platform setup codes are expected to provide a software
> > > node string property, named as "compatible". At this moment, the value of
> > > this string property is being used to match against the compatible entries
> > > in the of_device_id table. It can be extended in the future though.
> > I really do not want to see this patch
> 
> Whatever!
> 
> Then just stop the endless, bruth-force ranting on such a straight-forward thing.
> 
> > without very good justification
> 
> Justifications has been provided over and over again.
> 
> > (note, there were at least two attempts in the past
> 
> This exactly saying that the implementation is missing.

Now you count a third one for your pleasure :-)

P.S.
We already had this discussion in the past and this attitude won't help
moving forward.

-- 
With Best Regards,
Andy Shevchenko



