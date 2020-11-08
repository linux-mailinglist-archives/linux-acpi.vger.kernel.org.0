Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76A392AAC55
	for <lists+linux-acpi@lfdr.de>; Sun,  8 Nov 2020 17:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbgKHQ4k (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 8 Nov 2020 11:56:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:35208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727570AbgKHQ4j (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 8 Nov 2020 11:56:39 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 289C720678;
        Sun,  8 Nov 2020 16:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604854597;
        bh=HmpnTGD+sCqkzYKB+VNNoQPDyYLZ8DVZYqWfmSgpAfA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jTr8zTsz0WaJ6nnvT5Eg1Ll2ihGmqcyn+2SF+Wf/mrD2qllK/kFqFW/v7wcgZNefk
         zS7dIr/q6PaG6DfI7dBacAjjo5nnHikNbE1GU0b2Tz2VVRAwvJAMwi+yrMpSam0vAS
         yISkL1OxDj/prQqrSSSyaYuB90OjYqoYVe7sJd6Y=
Date:   Sun, 8 Nov 2020 16:56:21 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Javier =?UTF-8?B?R29uesOhbGV6?= <javier@javigon.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Bruno Meneguele <bmeneg@redhat.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Dan Murphy <dmurphy@ti.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Felipe Balbi <balbi@kernel.org>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Guenter Roeck <groeck@chromium.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Juergen Gross <jgross@suse.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Kranthi Kuntala <kranthi.kuntala@intel.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Len Brown <lenb@kernel.org>,
        Leonid Maksymchuk <leonmaxx@gmail.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Mark Gross <mgross@linux.intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Orson Zhai <orsonzhai@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Peter Rosin <peda@axentia.se>, Petr Mladek <pmladek@suse.com>,
        Philippe Bergheaud <felix@linux.ibm.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Rix <trix@redhat.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Vineela Tummalapalli <vineela.tummalapalli@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-pm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        netdev@vger.kernel.org, xen-devel@lists.xenproject.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 20/39] docs: ABI: testing: make the files compatible
 with ReST output
Message-ID: <20201108165621.4d0da3f4@archlinux>
In-Reply-To: <20201102154250.45bee17f@coco.lan>
References: <cover.1604042072.git.mchehab+huawei@kernel.org>
        <58cf3c2d611e0197fb215652719ebd82ca2658db.1604042072.git.mchehab+huawei@kernel.org>
        <5326488b-4185-9d67-fc09-79b911fbb3b8@st.com>
        <20201030110925.3e09d59e@coco.lan>
        <cb586ea3-b6e6-4e48-2344-2bd641e5323f@st.com>
        <20201102124641.GA881895@kroah.com>
        <20201102154250.45bee17f@coco.lan>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 2 Nov 2020 15:42:50 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Em Mon, 2 Nov 2020 13:46:41 +0100
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> escreveu:
> 
> > On Mon, Nov 02, 2020 at 12:04:36PM +0100, Fabrice Gasnier wrote:  
> > > On 10/30/20 11:09 AM, Mauro Carvalho Chehab wrote:    
> > > > Em Fri, 30 Oct 2020 10:19:12 +0100
> > > > Fabrice Gasnier <fabrice.gasnier@st.com> escreveu:
> > > >     
> > > >> Hi Mauro,
> > > >>
> > > >> [...]
> > > >>    
> > > >>>  
> > > >>> +What:		/sys/bus/iio/devices/iio:deviceX/in_count_quadrature_mode_available
> > > >>> +KernelVersion:	4.12
> > > >>> +Contact:	benjamin.gaignard@st.com
> > > >>> +Description:
> > > >>> +		Reading returns the list possible quadrature modes.
> > > >>> +
> > > >>> +What:		/sys/bus/iio/devices/iio:deviceX/in_count0_quadrature_mode
> > > >>> +KernelVersion:	4.12
> > > >>> +Contact:	benjamin.gaignard@st.com
> > > >>> +Description:
> > > >>> +		Configure the device counter quadrature modes:
> > > >>> +
> > > >>> +		channel_A:
> > > >>> +			Encoder A input servers as the count input and B as
> > > >>> +			the UP/DOWN direction control input.
> > > >>> +
> > > >>> +		channel_B:
> > > >>> +			Encoder B input serves as the count input and A as
> > > >>> +			the UP/DOWN direction control input.
> > > >>> +
> > > >>> +		quadrature:
> > > >>> +			Encoder A and B inputs are mixed to get direction
> > > >>> +			and count with a scale of 0.25.
> > > >>> +      
> > > >>    
> > > > 
> > > > Hi Fabrice,
> > > >     
> > > >> I just noticed that since Jonathan question in v1.
> > > >>
> > > >> Above ABI has been moved in the past as discussed in [1]. You can take a
> > > >> look at:
> > > >> b299d00 IIO: stm32: Remove quadrature related functions from trigger driver
> > > >>
> > > >> Could you please remove the above chunk ?
> > > >>
> > > >> With that, for the stm32 part:
> > > >> Acked-by: Fabrice Gasnier <fabrice.gasnier@st.com>    
> > > > 
> > > > 
> > > > Hmm... probably those were re-introduced due to a rebase. This
> > > > series were originally written about 1,5 years ago.
> > > > 
> > > > I'll drop those hunks.    
> > > 
> > > Hi Mauro, Greg,
> > > 
> > > I just figured out this patch has been applied with above hunk.
> > > 
> > > This should be dropped: is there a fix on its way already ?
> > > (I may have missed it)    
> > 
> > Can you send a fix for just this hunk?  
> 
> Hmm...
> 
> 	$ git grep /sys/bus/iio/devices/iio:deviceX/in_count_quadrature_mode_available
> 	Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8:What:                /sys/bus/iio/devices/iio:deviceX/in_count_quadrature_mode_available
> 	Documentation/ABI/testing/sysfs-bus-iio-lptimer-stm32:What:             /sys/bus/iio/devices/iio:deviceX/in_count_quadrature_mode_available
> 	Documentation/ABI/testing/sysfs-bus-iio-timer-stm32:What:               /sys/bus/iio/devices/iio:deviceX/in_count_quadrature_mode_available
> 
> Even re-doing the changes from 
> changeset b299d00420e2 ("IIO: stm32: Remove quadrature related functions from trigger driver")
> at Documentation/ABI/testing/sysfs-bus-iio-timer-stm32, there's still
> a third duplicate of some of those, as reported by the script:
> 
> 	$ ./scripts/get_abi.pl validate 2>&1|grep quadra
> 	Warning: /sys/bus/iio/devices/iio:deviceX/in_count0_quadrature_mode is defined 2 times:  Documentation/ABI/testing/sysfs-bus-iio-timer-stm32:117  Documentation/ABI/testing/sysfs-bus-iio-lptimer-stm32:14
> 	Warning: /sys/bus/iio/devices/iio:deviceX/in_count_quadrature_mode_available is defined 3 times:  Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8:2  Documentation/ABI/testing/sysfs-bus-iio-timer-stm32:111  Documentation/ABI/testing/sysfs-bus-iio-lptimer-stm32:8
> 
> As in_count_quadrature_mode_available is also defined at:
> 	Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8:2
> 
> The best here seems to have a patch that will also drop the other
> duplication of this, probably moving in_count_quadrature_mode_available
> to a generic node probably placing it inside 
> Documentation/ABI/testing/sysfs-bus-iio.

In this particular case it may be valid to do that, but it's not in
general without loosing information - see below.

> 
> Comments?
> 
> Thanks,
> Mauro
> 
> PS.: the IIO subsystem is the one that currently has more duplicated
> ABI entries:

That was intentional.  Often these provide more information on the
ABI for a particular device than is present in the base ABI doc.

A bit like when we have additional description for dt binding properties
for a particular device, even though they are standard properties.

Often a standard property allows for more values than the specific
one for a particular device.  There can also be obscuring coupling
between sysfs attributes due to hardware restrictions that we would
like to provide some explanatory info on.

I suppose we could add all this information to the parent doc but
that is pretty ugly and will make that doc very nasty to read.

Jonathan

> 
> $ ./scripts/get_abi.pl validate 2>&1|grep iio
> Warning: /sys/bus/iio/devices/iio:deviceX/in_accel_x_calibbias is defined 2 times:  Documentation/ABI/testing/sysfs-bus-iio-icm42600:0  Documentation/ABI/testing/sysfs-bus-iio:394
> Warning: /sys/bus/iio/devices/iio:deviceX/in_accel_y_calibbias is defined 2 times:  Documentation/ABI/testing/sysfs-bus-iio-icm42600:1  Documentation/ABI/testing/sysfs-bus-iio:395
> Warning: /sys/bus/iio/devices/iio:deviceX/in_accel_z_calibbias is defined 2 times:  Documentation/ABI/testing/sysfs-bus-iio-icm42600:2  Documentation/ABI/testing/sysfs-bus-iio:396
> Warning: /sys/bus/iio/devices/iio:deviceX/in_anglvel_x_calibbias is defined 2 times:  Documentation/ABI/testing/sysfs-bus-iio-icm42600:3  Documentation/ABI/testing/sysfs-bus-iio:397
> Warning: /sys/bus/iio/devices/iio:deviceX/in_anglvel_y_calibbias is defined 2 times:  Documentation/ABI/testing/sysfs-bus-iio-icm42600:4  Documentation/ABI/testing/sysfs-bus-iio:398
> Warning: /sys/bus/iio/devices/iio:deviceX/in_anglvel_z_calibbias is defined 2 times:  Documentation/ABI/testing/sysfs-bus-iio-icm42600:5  Documentation/ABI/testing/sysfs-bus-iio:399
> Warning: /sys/bus/iio/devices/iio:deviceX/in_count0_preset is defined 2 times:  Documentation/ABI/testing/sysfs-bus-iio-timer-stm32:100  Documentation/ABI/testing/sysfs-bus-iio-lptimer-stm32:0
> Warning: /sys/bus/iio/devices/iio:deviceX/in_count0_quadrature_mode is defined 2 times:  Documentation/ABI/testing/sysfs-bus-iio-timer-stm32:117  Documentation/ABI/testing/sysfs-bus-iio-lptimer-stm32:14
> Warning: /sys/bus/iio/devices/iio:deviceX/in_count_quadrature_mode_available is defined 3 times:  Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8:2  Documentation/ABI/testing/sysfs-bus-iio-timer-stm32:111  Documentation/ABI/testing/sysfs-bus-iio-lptimer-stm32:8
> Warning: /sys/bus/iio/devices/iio:deviceX/out_altvoltageY_frequency is defined 2 times:  Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4371:0  Documentation/ABI/testing/sysfs-bus-iio:599
> Warning: /sys/bus/iio/devices/iio:deviceX/out_altvoltageY_powerdown is defined 2 times:  Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4371:36  Documentation/ABI/testing/sysfs-bus-iio:588
> Warning: /sys/bus/iio/devices/iio:deviceX/out_currentY_raw is defined 2 times:  Documentation/ABI/testing/sysfs-bus-iio-light-lm3533-als:43  Documentation/ABI/testing/sysfs-bus-iio-health-afe440x:38
> Warning: /sys/bus/iio/devices/iio:deviceX/out_current_heater_raw is defined 2 times:  Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc2010:0  Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc100x:0
> Warning: /sys/bus/iio/devices/iio:deviceX/out_current_heater_raw_available is defined 2 times:  Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc2010:1  Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc100x:1
> Warning: /sys/bus/iio/devices/iio:deviceX/sensor_sensitivity is defined 2 times:  Documentation/ABI/testing/sysfs-bus-iio-distance-srf08:0  Documentation/ABI/testing/sysfs-bus-iio-proximity-as3935:8
> Warning: /sys/bus/iio/devices/triggerX/sampling_frequency is defined 2 times:  Documentation/ABI/testing/sysfs-bus-iio-timer-stm32:92  Documentation/ABI/testing/sysfs-bus-iio:45

