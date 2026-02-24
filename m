Return-Path: <linux-acpi+bounces-21122-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yL5RO6J9nWk1QQQAu9opvQ
	(envelope-from <linux-acpi+bounces-21122-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 11:29:54 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83882185576
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 11:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2ECE7304653F
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 10:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FFE378822;
	Tue, 24 Feb 2026 10:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="djirx+/c"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F91378803;
	Tue, 24 Feb 2026 10:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771928988; cv=none; b=f+/npB+N1BgTrdJ78U6zlcVr2Uchr5fC1IbZWBmiEoX3wEz829l6eYmlFURK74kylEm2Sbi96IXJORiVEfk8Sj+xq6D8eoDhnQVKpMa9A9wCgxlHi8BYK1pC7V7HM1vhfF7KhYzWjy5aFsA3pjt5WVmv7i7zLqYESzSAcCPa5kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771928988; c=relaxed/simple;
	bh=GNqN7EPXAOQa1OHTwy1jFX9pHGrz2But+AqpMLaeWT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M3iY1iCDGPcMS+3X8ueUQ2kzrxjJ6CAFYksCOGQUQfAXZBeNU02+hrbmXu1juNCrliQgwaFtzRfUpl+zekYcuIuomPhJyZmbOzSlYzgFjufFyYh1eOkpW9JHj40v/QCeMSu4ML2WLY0zjcUxaRxah14R90krXrBq2j/2HmqIw2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=djirx+/c; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771928987; x=1803464987;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GNqN7EPXAOQa1OHTwy1jFX9pHGrz2But+AqpMLaeWT8=;
  b=djirx+/ceS1UqmwmVWQalgY3aeUmnVyL4+XPSdjasG8CJw+hT/humnyt
   nfwAYX7bGR8e3SlUhys2URPAPeHAuBZjJg5hc+GYTAb/oSZYXTQ/5qcEZ
   5hIr+KL1PJBWmMYcgNoPKUOxik/+wJyVJOKS2avds5mWJ+pqpfZ+LViuD
   e4V8HbqfPJIBPuH+WpJrw4TTJejGlari/qgb3N2X0IW3otlCziBkm0kH5
   NUYESPs8YAjJ2k76Ro9/eZLgY5N3lsncalSh51auFTqHsNUEkOP7e/Q8R
   cWK3wGlW/LaglWOdYEkP/WBcVZpTzMKscBeCYm6DwzLIbyrSrr+HPBauh
   g==;
X-CSE-ConnectionGUID: ydpjVBgiSsS2Mwvh6+6vQw==
X-CSE-MsgGUID: nVfwyuAGSUekOVLolnNX7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="73002824"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="73002824"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 02:29:46 -0800
X-CSE-ConnectionGUID: +vXMxhPqTcCAisY8daAkZw==
X-CSE-MsgGUID: N92Jve2VQWG5lyEL6OMctw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="219958680"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.146])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 02:29:40 -0800
Date: Tue, 24 Feb 2026 12:29:36 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com,
	Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	linux-acpi@vger.kernel.org,
	Hans de Goede <johannes.goede@oss.qualcomm.com>,
	Rob Herring <robh@kernel.org>,
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
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v5 2/9] serdev: Add an API to find the serdev controller
 associated with the devicetree node
Message-ID: <aZ19kFCv_3QUkvPL@smile.fi.intel.com>
References: <20260224-pci-m2-e-v5-0-dd9b9501d33c@oss.qualcomm.com>
 <20260224-pci-m2-e-v5-2-dd9b9501d33c@oss.qualcomm.com>
 <CAMRc=MethnZu_GrujadpBZwj4SpgdNXEnTfEikSvPkO2f9MJjg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=MethnZu_GrujadpBZwj4SpgdNXEnTfEikSvPkO2f9MJjg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,kernel.org,vger.kernel.org,linaro.org,linuxfoundation.org,linux.dev,linux.intel.com,squebb.ca,gmail.com,holtmann.org,bgdev.pl];
	TAGGED_FROM(0.00)[bounces-21122-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi,manivannan.sadhasivam.oss.qualcomm.com,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,smile.fi.intel.com:mid]
X-Rspamd-Queue-Id: 83882185576
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 02:16:17AM -0800, Bartosz Golaszewski wrote:
> On Tue, 24 Feb 2026 06:30:48 +0100, Manivannan Sadhasivam via B4 Relay
> <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> said:
> >
> > Add of_find_serdev_controller_by_node() API to find the serdev controller
> > device associated with the devicetree node.

...

> > +struct serdev_controller *of_find_serdev_controller_by_node(struct device_node *node)
> > +{
> > +	struct device *dev = bus_find_device_by_of_node(&serdev_bus_type, node);
> > +
> > +	return (dev && dev->type == &serdev_ctrl_type) ? to_serdev_controller(dev) : NULL;
> > +}
> > +EXPORT_SYMBOL_GPL(of_find_serdev_controller_by_node);
> 
> I'm not sure if I commented on it before but there's no reason for this to be
> OF-centric. It would work equally well as (I think the same should keep the
> "serdev" prefix too for correct namespacing):
> 
> struct serdev_controller *serdev_find_controller_by_fwnode(struct
> fwnode_handle *fwnode)
> {
> 	struct device *dev = bus_find_device_by_fwnode();
> 
> 	...
> }
> 
> It would be more flexible and users can always use to_of_node().

IIRC it was discussed already and the fact of use only in DT overlays and
absence of the user for all this time makes it feel like solving non-existing
problem. So OF-centric in this case seems to be fine.

-- 
With Best Regards,
Andy Shevchenko



