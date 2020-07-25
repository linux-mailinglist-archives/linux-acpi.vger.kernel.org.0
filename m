Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 051B822D655
	for <lists+linux-acpi@lfdr.de>; Sat, 25 Jul 2020 11:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgGYJMt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 25 Jul 2020 05:12:49 -0400
Received: from mga09.intel.com ([134.134.136.24]:14763 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726583AbgGYJMt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 25 Jul 2020 05:12:49 -0400
IronPort-SDR: ugtaig2pzmPrm923mnSTJ5x+8SCSzZ1gvPrmrMWLq8ewaWxGEyRx05Zj8pr5Qr5/aSkqe7NjB9
 kJF1nIRKWrRQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9692"; a="152096378"
X-IronPort-AV: E=Sophos;i="5.75,394,1589266800"; 
   d="scan'208";a="152096378"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2020 02:12:48 -0700
IronPort-SDR: gOzP//zZ6j2kiA9GjZd7m2HA8PgWDRWUZ/wYEfKzGLbtNZWszauNz3kZXmqiwzogVMHf0v5fc9
 yrymHi8gVaqQ==
X-IronPort-AV: E=Sophos;i="5.75,394,1589266800"; 
   d="scan'208";a="329154913"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2020 02:12:46 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id 2A5112079D; Sat, 25 Jul 2020 12:12:44 +0300 (EEST)
Date:   Sat, 25 Jul 2020 12:12:44 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, dave.jiang@intel.com,
        ira.weiny@intel.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
Subject: Re: [PATCH] ACPI: Replace HTTP links with HTTPS ones
Message-ID: <20200725091244.GE16711@paasikivi.fi.intel.com>
References: <20200717182436.75214-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717182436.75214-1-grandmaster@al2klimov.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Alexander,

Thanks for the patch.

On Fri, Jul 17, 2020 at 08:24:36PM +0200, Alexander A. Klimov wrote:
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
> 	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>             If both the HTTP and HTTPS versions
>             return 200 OK and serve the same content:
>               Replace HTTP with HTTPS.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> ---
>  Continuing my work started at 93431e0607e5.
>  See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
> 
>  If there are any URLs to be removed completely or at least not just HTTPSified:
>  Just clearly say so and I'll *undo my change*.
>  See also: https://lkml.org/lkml/2020/6/27/64
> 
>  If there are any valid, but yet not changed URLs:
>  See: https://lkml.org/lkml/2020/6/26/837
> 
>  If you apply the patch, please let me know.
> 
>  Sorry again to all maintainers who complained about subject lines.
>  Now I realized that you want an actually perfect prefixes,
>  not just subsystem ones.
>  I tried my best...
>  And yes, *I could* (at least half-)automate it.
>  Impossible is nothing! :)
> 
> 
>  .../firmware-guide/acpi/DSD-properties-rules.rst       |  4 ++--
>  .../firmware-guide/acpi/dsd/data-node-references.rst   |  4 ++--
>  Documentation/firmware-guide/acpi/dsd/graph.rst        | 10 +++++-----
>  Documentation/firmware-guide/acpi/dsd/leds.rst         |  6 +++---

For ACPI _DSD and data-node-references:

Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus
