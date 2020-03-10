Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3FC817F1DE
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Mar 2020 09:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgCJIXi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 10 Mar 2020 04:23:38 -0400
Received: from mga07.intel.com ([134.134.136.100]:27515 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbgCJIXh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 10 Mar 2020 04:23:37 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Mar 2020 01:23:37 -0700
X-IronPort-AV: E=Sophos;i="5.70,535,1574150400"; 
   d="scan'208";a="265545303"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Mar 2020 01:23:35 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 32F98209DF; Tue, 10 Mar 2020 10:23:33 +0200 (EET)
Date:   Tue, 10 Mar 2020 10:23:33 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, kernel@pengutronix.de,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH] Documentation: ACPI: fix port numbering example
Message-ID: <20200310082333.GZ5379@paasikivi.fi.intel.com>
References: <20200305145601.3467-1-m.felsch@pengutronix.de>
 <20200309133757.GS5379@paasikivi.fi.intel.com>
 <20200310061458.6ruh2omqqcugemqt@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310061458.6ruh2omqqcugemqt@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Marco,

On Tue, Mar 10, 2020 at 07:14:58AM +0100, Marco Felsch wrote:
> Hi Sakari,
> 
> On 20-03-09 15:37, Sakari Ailus wrote:
> > Hi Marco,
> > 
> > Thanks for the patch.
> > 
> > On Thu, Mar 05, 2020 at 03:56:01PM +0100, Marco Felsch wrote:
> > > If I understood it right the ports should be numbered using the "port"
> > > property and not the "reg" property. I stumbled over it during
> > > extending the v4l2_fwnode_parse_link() helper which also use the "port"
> > > property.
> > > 
> > > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > > ---
> > > Hi,
> > > 
> > > I don't know if this is right since I'm not a ACPI guy *sorry*
> > > Anyway reading the doc description and the v4l2_fwnode_parse_link() code
> > > give me a 2/3 chance.
> > 
> > Looking at the documentation, this indeed seems to be a bug in the
> > documentation. The code is right, as is the example. As the property was
> > previously called "port", there is no actual harm even if someone just read
> > the documentation, and not the examples or the code parsing this.
> > 
> > The buggy patch is a4138e7c12287268348cc2dcad414a62c515d77a .
> > 
> > Could you use this instead?
> 
> Of course, thanks for the clarification. It seems that we need to update the
> v4l2_fwnode_parse_link() too?

Well, yes. This has escaped me because there have been no ACPI users of
that function. In fact, there are only two users in total. That suggests it
may not be that useful after all as other drivers do the same job without.

Feel free to write a patch. :-)

-- 
Kind regards,

Sakari Ailus
