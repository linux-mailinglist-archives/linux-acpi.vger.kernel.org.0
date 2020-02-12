Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFCB815A8C9
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2020 13:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbgBLMIk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 12 Feb 2020 07:08:40 -0500
Received: from mga04.intel.com ([192.55.52.120]:20612 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727041AbgBLMIk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 12 Feb 2020 07:08:40 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2020 04:08:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,428,1574150400"; 
   d="scan'208";a="347503544"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 12 Feb 2020 04:08:36 -0800
Received: by lahna (sSMTP sendmail emulation); Wed, 12 Feb 2020 14:08:36 +0200
Date:   Wed, 12 Feb 2020 14:08:36 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Jean Delvare <jdelvare@suse.de>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org, Tom Abraham <tabraham@suse.com>
Subject: Re: [PATCH 1/3] ACPICA: Introduce ACPI_ACCESS_BIT_WIDTH() macro
Message-ID: <20200212120836.GB2667@lahna.fi.intel.com>
References: <20200211180331.11dbe525@endymion>
 <20200212110540.83559-1-mika.westerberg@linux.intel.com>
 <20200212125244.2b61202e@endymion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212125244.2b61202e@endymion>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Feb 12, 2020 at 12:52:44PM +0100, Jean Delvare wrote:
> On Wed, 12 Feb 2020 14:05:38 +0300, Mika Westerberg wrote:
> > Sometimes it is useful to find the access_width field value in bytes and
> > not in bits so add a helper that can be used for this purpose.
> 
> s/ACPI_ACCESS_BIT_WIDTH/ACPI_ACCESS_BYTE_WIDTH/ in the subject.

Indeed.

> > Suggested-by: Jean Delvare <jdelvare@suse.de>
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > ---
> >  include/acpi/actypes.h | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
> > index a2583c2bc054..77d40b02f62a 100644
> > --- a/include/acpi/actypes.h
> > +++ b/include/acpi/actypes.h
> > @@ -537,6 +537,7 @@ typedef u64 acpi_integer;
> >   * struct acpi_resource_generic_register.
> >   */
> >  #define ACPI_ACCESS_BIT_WIDTH(size)     (1 << ((size) + 2))
> > +#define ACPI_ACCESS_BYTE_WIDTH(size)    (ACPI_ACCESS_BIT_WIDTH(size) / 8)
> 
> One of the points of having this macro being to avoid needless math,
> I'd rather do:
> 
> #define ACPI_ACCESS_BYTE_WIDTH(size)    (1 << ((size) - 1))
> 
> Some compilers might be able to optimize it, but maybe not all, and I
> see little point in giving the compiler more work anyway when it can be
> easily avoided.
> 
> You may also want to replace "bit" by "bit or byte in the comment right
> before the macros.

OK, I'll do that.

> >  
> >  /*******************************************************************************
> >   *
> 
> Reviewed-by: Jean Delvare <jdelvare@suse.de>

Thanks!
