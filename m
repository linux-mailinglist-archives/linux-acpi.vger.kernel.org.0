Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC706326C6
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Jun 2019 04:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfFCCtM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 2 Jun 2019 22:49:12 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:47830 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfFCCtL (ORCPT
        <rfc822;groupwise-linux-acpi@vger.kernel.org:0:0>);
        Sun, 2 Jun 2019 22:49:11 -0400
Received: from linux-8mug (prva10-snat226-2.provo.novell.com [137.65.226.36])
        by smtp2.provo.novell.com with ESMTP (TLS encrypted); Sun, 02 Jun 2019 20:49:02 -0600
Date:   Mon, 3 Jun 2019 10:48:50 +0800
From:   Chester Lin <clin@suse.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, jlee@suse.com, mhocko@suse.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] ACPI / device_sysfs: Add eject show attr to monitor
 eject status
Message-ID: <20190603024850.GA664@linux-8mug>
References: <20190531065642.13254-1-clin@suse.com>
 <20190531065642.13254-4-clin@suse.com>
 <20190531133859.GA18231@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531133859.GA18231@kroah.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, May 31, 2019 at 06:38:59AM -0700, Greg KH wrote:
> On Fri, May 31, 2019 at 02:56:42PM +0800, Chester Lin wrote:
> > An acpi_eject_show attribute for users to monitor current status because
> > sometimes it might take time to finish an ejection so we need to know
> > whether it is still in progress or not.
> > 
> > Signed-off-by: Chester Lin <clin@suse.com>
> > ---
> >  drivers/acpi/device_sysfs.c | 20 +++++++++++++++++++-
> >  drivers/acpi/internal.h     |  1 +
> >  drivers/acpi/scan.c         | 27 +++++++++++++++++++++++++++
> >  3 files changed, 47 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
> > index 78c2653bf020..70b22eec6bbc 100644
> > --- a/drivers/acpi/device_sysfs.c
> > +++ b/drivers/acpi/device_sysfs.c
> > @@ -403,7 +403,25 @@ acpi_eject_store(struct device *d, struct device_attribute *attr,
> >  	return status == AE_NO_MEMORY ? -ENOMEM : -EAGAIN;
> >  }
> >  
> > -static DEVICE_ATTR(eject, 0200, NULL, acpi_eject_store);
> > +static ssize_t acpi_eject_show(struct device *d,
> > +				struct device_attribute *attr, char *buf)
> > +{
> > +	struct acpi_device *acpi_device = to_acpi_device(d);
> > +	acpi_object_type not_used;
> > +	acpi_status status;
> > +
> > +	if ((!acpi_device->handler || !acpi_device->handler->hotplug.enabled)
> > +	    && !acpi_device->driver)
> > +		return -ENODEV;
> > +
> > +	status = acpi_get_type(acpi_device->handle, &not_used);
> > +	if (ACPI_FAILURE(status) || !acpi_device->flags.ejectable)
> > +		return -ENODEV;
> > +
> > +	return sprintf(buf, "%s\n", acpi_eject_status_string(acpi_device));
> > +}
> > +
> > +static DEVICE_ATTR(eject, 0644, acpi_eject_show, acpi_eject_store);
> 
> DEVICE_ATTR_RW()?
> 
> And you need to document the new sysfs file in Documentation/ABI/
> 
> thanks,
> 
> greg k-h
> 

Hi Greg,

Thank you for the reminder and I will fix these two in v2.

Regards,
Chester
