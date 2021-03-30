Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46EEE34E449
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Mar 2021 11:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbhC3J1I (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 30 Mar 2021 05:27:08 -0400
Received: from mga02.intel.com ([134.134.136.20]:29497 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231773AbhC3J0j (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 30 Mar 2021 05:26:39 -0400
IronPort-SDR: DS+na1goAYLlBj/96DxtW4sLhU/3Sp2u5JboPgAb0IaWsuuj0S9gTXtjIEhXS1g7ndOXOVgo48
 RP5crxo1+YtQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9938"; a="178860870"
X-IronPort-AV: E=Sophos;i="5.81,290,1610438400"; 
   d="scan'208";a="178860870"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 02:26:38 -0700
IronPort-SDR: JFuYIEolFJdWz4Sv28R+nQxwOke/2rsulxP06Fia9r9cjpjPcXAywFTcgkq40Tk6+sELd+CG/0
 Ej8txvdJS3Pg==
X-IronPort-AV: E=Sophos;i="5.81,290,1610438400"; 
   d="scan'208";a="516364791"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 02:26:35 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lRAds-00HHww-Nn; Tue, 30 Mar 2021 12:26:32 +0300
Date:   Tue, 30 Mar 2021 12:26:32 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Daniel Scally <djrscally@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Yong Zhi <yong.zhi@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v2 5/6] software node: Introduce
 SOFTWARE_NODE_REFERENCE() helper macro
Message-ID: <YGLuyKFbDgVLU2OW@smile.fi.intel.com>
References: <20210329151207.36619-1-andriy.shevchenko@linux.intel.com>
 <20210329151207.36619-5-andriy.shevchenko@linux.intel.com>
 <5e76c3b8-d154-e5ca-25d8-290376469e5a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e76c3b8-d154-e5ca-25d8-290376469e5a@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Mar 29, 2021 at 11:45:29PM +0100, Daniel Scally wrote:
> On 29/03/2021 16:12, Andy Shevchenko wrote:
> > This is useful to assign software node reference with arguments
> > in a common way. Moreover, we have already couple of users that
> > may be converted. And by the fact, one of them is moved right here
> > to use the helper.

...

> > +		SOFTWARE_NODE_REFERENCE(&nodes[0]),
> > +		SOFTWARE_NODE_REFERENCE(&nodes[1], 3, 4),

...

> > +#define SOFTWARE_NODE_REFERENCE(_ref_, ...)			\
> > +(const struct software_node_ref_args) {				\
> > +	.node = _ref_,						\
> > +	.nargs = ARRAY_SIZE(((u64[]){ 0, ##__VA_ARGS__ })) - 1,	\
> > +	.args = { __VA_ARGS__ },				\
> > +}

...

> > +	{ .pointer = &SOFTWARE_NODE_REFERENCE(_ref_, ##__VA_ARGS__), },	\
> 
> What are the .args intended to be used for? I actually had it in mind to
> replace this with a simple pointer to a struct software_node, because I
> can't see any users of them and the fact that it's actually storing a
> pointer to a new variable is something that confused me for a good long
> time when I wrote the cio2-bridge (though that's mostly due to my
> relative inexperience of course, but still)

It's to be in align with DT phandle references that can take arguments. While
for now, indeed, we have no users of this, it might be changed in the future
(I hadn't checked DesignWare DMA where I would like to transform the code to
 use device properties eventually and there it might be the case).

-- 
With Best Regards,
Andy Shevchenko


