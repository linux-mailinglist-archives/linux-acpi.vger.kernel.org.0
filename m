Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23FA93D590C
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jul 2021 14:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233693AbhGZLUI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 26 Jul 2021 07:20:08 -0400
Received: from mga02.intel.com ([134.134.136.20]:53150 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233719AbhGZLUI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 26 Jul 2021 07:20:08 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10056"; a="199406459"
X-IronPort-AV: E=Sophos;i="5.84,270,1620716400"; 
   d="scan'208";a="199406459"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2021 05:00:32 -0700
X-IronPort-AV: E=Sophos;i="5.84,270,1620716400"; 
   d="scan'208";a="417032105"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2021 05:00:30 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id AB859205CF;
        Mon, 26 Jul 2021 15:00:27 +0300 (EEST)
Date:   Mon, 26 Jul 2021 15:00:27 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 2/3] docs: firmware-guide: acpi: dsd: graph.rst: replace
 some characters
Message-ID: <20210726120027.GC3@paasikivi.fi.intel.com>
References: <cover.1626947264.git.mchehab+huawei@kernel.org>
 <a65b04a5cf341cff02d4b514dd4889b4fa4f94b8.1626947264.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a65b04a5cf341cff02d4b514dd4889b4fa4f94b8.1626947264.git.mchehab+huawei@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Mauro,

On Thu, Jul 22, 2021 at 11:50:02AM +0200, Mauro Carvalho Chehab wrote:
> The conversion tools used during DocBook/LaTeX/html/Markdown->ReST
> conversion and some cut-and-pasted text contain some characters that
> aren't easily reachable on standard keyboards and/or could cause
> troubles when parsed by the documentation build system.
> 
> Replace the occurences of the following characters:
> 
> 	- U+00a0 (' '): NO-BREAK SPACE
> 	  as it can cause lines being truncated on PDF output
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/firmware-guide/acpi/dsd/graph.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/firmware-guide/acpi/dsd/graph.rst b/Documentation/firmware-guide/acpi/dsd/graph.rst
> index 4341299aa937..0ced07cb1be3 100644
> --- a/Documentation/firmware-guide/acpi/dsd/graph.rst
> +++ b/Documentation/firmware-guide/acpi/dsd/graph.rst
> @@ -159,7 +159,7 @@ References
>  
>  [2] Devicetree. https://www.devicetree.org, referenced 2016-10-03.
>  
> -[3] Documentation/devicetree/bindings/graph.txt
> +[3] Documentation/devicetree/bindings/graph.txt

I probably wrote this as a non-break space is produced by space + mod5,
preceded by opening bracket which also requires mod5.

The file is there but the file has moved to DT schema repository. I believe
the correct reference is:

https://github.com/devicetree-org/dt-schema/blob/master/schemas/graph.yaml

>  
>  [4] Device Properties UUID For _DSD.
>      https://www.uefi.org/sites/default/files/resources/_DSD-device-properties-UUID.pdf,

-- 
Kind regards,

Sakari Ailus
