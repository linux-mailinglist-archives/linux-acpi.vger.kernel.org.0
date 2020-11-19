Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 939792B93BC
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Nov 2020 14:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgKSNjp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 19 Nov 2020 08:39:45 -0500
Received: from mga18.intel.com ([134.134.136.126]:31000 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726407AbgKSNjp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 19 Nov 2020 08:39:45 -0500
IronPort-SDR: PjvZHtmNwVKS4koAbI8rSyZuAOF9ZMyPTFKy6N2uQqlQag0SOVcX9WTjb8vFfoeXAxVxOg7JAJ
 6xexPtg+EfbA==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="159060287"
X-IronPort-AV: E=Sophos;i="5.77,490,1596524400"; 
   d="scan'208";a="159060287"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 05:39:44 -0800
IronPort-SDR: qmO9at6lIvf1VQofucHqKo4928urj40vKFCphf8Pa+VPm8R4L2bmqkU4LLMz1ZsQe6HmeVLxzp
 7S1hXpPimlug==
X-IronPort-AV: E=Sophos;i="5.77,490,1596524400"; 
   d="scan'208";a="357380931"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 05:39:41 -0800
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id E3E2420AA6; Thu, 19 Nov 2020 15:39:39 +0200 (EET)
Date:   Thu, 19 Nov 2020 15:39:39 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Flavio Suligoi <f.suligoi@asem.it>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Alexander A . Klimov" <grandmaster@al2klimov.de>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] docs: ACPI: dsd: enable hyperlink in final references
Message-ID: <20201119133939.GW3940@paasikivi.fi.intel.com>
References: <20201119125801.719775-1-f.suligoi@asem.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119125801.719775-1-f.suligoi@asem.it>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Nov 19, 2020 at 01:58:01PM +0100, Flavio Suligoi wrote:
> For inline web links, no special markup are needed.
> 
> Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>

Thanks!

Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus
