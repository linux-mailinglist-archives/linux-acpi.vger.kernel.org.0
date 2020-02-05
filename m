Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1016D15353F
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Feb 2020 17:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgBEQau (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 5 Feb 2020 11:30:50 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46976 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbgBEQau (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Feb 2020 11:30:50 -0500
Received: by mail-pf1-f193.google.com with SMTP id k29so1447434pfp.13;
        Wed, 05 Feb 2020 08:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oR86uEA/4GyGiJtf79HkkGTWnpzP1H2FQHTGa8XT2B4=;
        b=K6TcvsUYBNPuNvk68fl5gnw2+qx6fkUwHmLXcFNJezRC0KVyR5+JPUNB9MTZ4WnplH
         ifQ36vFth1fNNJ9XNNk8e/8EtgJPmMvjsNVRza4aD6+5wEiv46zA29/vVINUnDyWn6Zp
         x3MMcy2XFPulbdWIVja1FVSywaCalx9XQiy8/9/dal+1scj11DHSk5BB1970KXEMUkj6
         o7V/EbHCowKIYeWWPjCzXmM5MIUrOrCrpG1Whv29haWj45FyXw1BTo5Mg7wwWo3wrnck
         wQhzwjiNL/m1/dr2n5x8bGSesHCWS87jnx6jN6cxUDHm3UJscwotXPeCGe0q/FaywOIR
         esEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=oR86uEA/4GyGiJtf79HkkGTWnpzP1H2FQHTGa8XT2B4=;
        b=GabiROSFM3CNuo+QsJ4DMnf+Az7p7Qdw1PrGd5tmelWNZzb3bL83XFHRtgqOcXTT+P
         4wm2Rc5LBnw9ItYGCRzQB5UaVWwDHNkwPO9eumwWlJmYxCV+/aIr76zE87i6TD794L3p
         hSc4gSVXeKt4HT+cp3+YUyB+LiUOIE8zE330LOtJwVHdmycxNHgdz4/85NIGWK2abx58
         16FSD8KFgu94uGczTZedPbYJTnPF1Ve9ZjUK84L+358d3mbg6i4Syo5nGl5ZojEn9ES5
         4sCmCxBvQwuF7PbLqg02Y+qMymYhCXwJQLTw/rrEOkiwvBIUvrUHaOxME1SJ+aHULJjI
         5giw==
X-Gm-Message-State: APjAAAXoozHjipqx7bI/Q/CLRuB4u9pH+gy7K196TEjsddKhHdt/Xi/T
        3gt8dlTFyUQYKdOJKSflZcA=
X-Google-Smtp-Source: APXvYqyYWNkdo3UpANEYK3QsdDFI13Z9Qw57Dbeh2y5pwKPW5iIhyiNDyYhDsvTPWdcNnfC7OVnsgw==
X-Received: by 2002:a63:7c2:: with SMTP id 185mr36415197pgh.446.1580920249982;
        Wed, 05 Feb 2020 08:30:49 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a18sm28644108pfl.138.2020.02.05.08.30.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Feb 2020 08:30:49 -0800 (PST)
Date:   Wed, 5 Feb 2020 08:30:48 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Jean Delvare <jdelvare@suse.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, Tom Abraham <tabraham@suse.com>
Subject: Re: Forcing non-ACPI watchdog driver
Message-ID: <20200205163048.GD25403@roeck-us.net>
References: <1580915129.23547.3.camel@suse.de>
 <20200205152435.GE2667@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205152435.GE2667@lahna.fi.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Feb 05, 2020 at 05:24:35PM +0200, Mika Westerberg wrote:
> On Wed, Feb 05, 2020 at 04:05:29PM +0100, Jean Delvare wrote:
> > Hi all,
> 
> Hi,
> 
> > Is there a way to prevent the ACPI WDAT watchdog interface from being
> > used and force the use of a native watchdog driver instead?
> > 
> > I have a customer who reports a regression on kernel upgrade. Old
> > kernel (v4.4) uses iTCO_wdt and watchdog works, new kernel (v4.12) uses
> > wdat_wdt and watchdog doesn't work (instant reboot when opening the
> > device). While I'm going to look for fixes to backport, I think it
> > would be pretty convenient to have a way to just revert to the working
> > driver until the new driver is fixed somehow. But I can't see any way
> > to do that at the moment, short of disabling ACPI completely, which is
> > definitely too extreme to be considered.
> > 
> > Am I missing something?
> 
> You should be able to revert to iTCO_wdt by simply disabling
> CONFIG_WDAT_WDT from .config. Then acpi_has_watchdog() returns false
> which means that iTCO_wdt is used instead.

That may not be possible in a generic distribution.

Guenter
