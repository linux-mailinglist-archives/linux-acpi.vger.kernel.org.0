Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 444DE30F22
	for <lists+linux-acpi@lfdr.de>; Fri, 31 May 2019 15:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfEaNm0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 31 May 2019 09:42:26 -0400
Received: from mga07.intel.com ([134.134.136.100]:24561 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbfEaNm0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 31 May 2019 09:42:26 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 May 2019 06:42:25 -0700
X-ExtLoop1: 1
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 31 May 2019 06:42:22 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 31 May 2019 16:42:21 +0300
Date:   Fri, 31 May 2019 16:42:21 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy@infradead.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v4 00/16] Software fwnode references
Message-ID: <20190531134221.GD7167@kuha.fi.intel.com>
References: <20190522105113.11153-1-heikki.krogerus@linux.intel.com>
 <eb63bdfe-e863-2041-9b90-81b423f92baa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb63bdfe-e863-2041-9b90-81b423f92baa@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, May 29, 2019 at 11:29:10AM +0200, Hans de Goede wrote:
> Hi,
> 
> On 5/22/19 12:50 PM, Heikki Krogerus wrote:
> > Hi,
> > 
> > I'm not splitting this series in two after all. After thinking about
> > this for some time, I decided to add support for static software
> > nodes. I did not want to support them because I don't want to make it
> > easy to maintain board files, but in end they make the use of the
> > software nodes so much more easier compared to if we always had to
> > dynamically allocate them that it's a no-brainer. The references can
> > now be also described statically. Actually, those can now only be
> > described statically.
> > 
> > Hans! I applied (hopefully) all of the fixes you proposed in v3. I
> > hope you have time to test these.
> 
> I've just ran various tests with the entire series applied and
> everything (superspeed host, superspeed device, DP over Type-C,
> PD charging) seems to work fin, so you can add my:
> 
> Tested-by: Hans de Goede <hdegoede@redhat.com>
> 
> To the entire series.
> 
> I've 2 very minor nitpicks about the intel_cht_int33fe patches,
> with those fixed, you can also add my:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> 
> To the intel_cht_int33fe patches. I will reply to the
> 2 individual patches for which I've some remarks
> separately.

Thanks Hans! I'll fix those.

Cheers,

-- 
heikki
