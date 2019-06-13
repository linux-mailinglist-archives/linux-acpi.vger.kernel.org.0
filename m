Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A41C44D68
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Jun 2019 22:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbfFMU2N (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 13 Jun 2019 16:28:13 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:60351 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbfFMU2M (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 13 Jun 2019 16:28:12 -0400
Received: from 79.184.253.190.ipv4.supernova.orange.pl (79.184.253.190) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id c5908a95db0f861a; Thu, 13 Jun 2019 22:28:09 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy@infradead.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v5 00/16] Software fwnode references
Date:   Thu, 13 Jun 2019 22:28:08 +0200
Message-ID: <3636687.Nc99FdWIM2@kreacher>
In-Reply-To: <20190531141547.22728-1-heikki.krogerus@linux.intel.com>
References: <20190531141547.22728-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Friday, May 31, 2019 4:15:31 PM CEST Heikki Krogerus wrote:
> Hi,
> 
> This is the fourth, and hopefully the final version, of my proposal to
> make it possible to use fwnode_property_get_reference_args() also with
> software nodes. The two issues reported by Hans in v4 are now fixed,
> which were a typo in a comment, and the fwnode->secondary->secondary
> of max17074 needs to have value ERR_PTR(-ENODEV).
> 
> v4 cover letter:
> 
> I'm not splitting this series in two after all. After thinking about
> this for some time, I decided to add support for static software
> nodes. I did not want to support them because I don't want to make it
> easy to maintain board files, but in end they make the use of the
> software nodes so much more easier compared to if we always had to
> dynamically allocate them that it's a no-brainer. The references can
> now be also described statically. Actually, those can now only be
> described statically.
> 
> Hans! I applied (hopefully) all of the fixes you proposed in v3. I
> hope you have time to test these.
> 
> v3 cover letter:
> 
> This is the third version of my proposal to add reference handling to
> the software node code. In this version I renamed ACPI_NAME_SIZE to
> ACPI_NAMESEG_SIZE in 6/13, and slit patch 9/13 in two separate patches
> (9/13 and 10/13) as suggested by Andy. Patch 9/13 will now only move
> the registration of max17047 out of probe, and 10/13 will introduce
> the software nodes.
> 
> v2 cover letter:
> 
> This is the second version of this series. In this version I'm
> introducing a new helper device_find_child_by_name() as proposed
> by Andy. Andy requested also another helper that could be used for
> chaining the fwnodes, but I decided not to add that now. I would like
> to still think about how we should handle exceptions like if there
> already is a secondary node assigned for a node.
> 
> v1 cover letter:
> 
> This series adds support for software fwnode reference handling. In
> practice it means making fwnode_property_get_reference_args() function
> usable in the drivers also with software nodes. I send the series
> originally as RFC [1].
> 
> As the first user for the software node references, I'm converting
> intel_cht_int33fe.c to use them as part of the series.
> 
> [1] https://lkml.org/lkml/2019/3/15/457
> 
> thanks,
> 
> Heikki Krogerus (16):
>   software node: Allow node creation without properties
>   software node: Simplify software_node_release() function
>   software node: Add support for static node descriptors
>   software node: Use kobject name when finding child nodes by name
>   software node: Add software_node_get_reference_args()
>   driver core: Add helper device_find_child_by_name()
>   ACPI / property: Don't limit named child node matching to data nodes
>   device property: Introduce fwnode_find_reference()
>   device connection: Find connections also by checking the references
>   usb: typec: Registering real device entries for the muxes
>   platform/x86: intel_cht_int33fe: Register max17047 in its own function
>   platform/x86: intel_cht_int33fe: Remove unused fusb302 device property
>   platform/x86: intel_cht_int33fe: Provide software nodes for the
>     devices
>   platform/x86: intel_cht_int33fe: Provide fwnode for the USB connector
>   platform/x86: intel_cht_int33fe: Supply fwnodes for the external
>     dependencies
>   platform/x86: intel_cht_int33fe: Replacing the old connections with
>     references
> 
>  drivers/acpi/property.c                  |  26 +-
>  drivers/base/core.c                      |  28 ++
>  drivers/base/devcon.c                    |  26 ++
>  drivers/base/property.c                  |  24 ++
>  drivers/base/swnode.c                    | 324 +++++++++++++++++------
>  drivers/platform/x86/intel_cht_int33fe.c | 291 ++++++++++++++++----
>  drivers/usb/roles/class.c                |   2 +-
>  drivers/usb/typec/bus.h                  |  15 ++
>  drivers/usb/typec/class.c                |  17 +-
>  drivers/usb/typec/mux.c                  | 238 ++++++++++++-----
>  drivers/usb/typec/mux/pi3usb30532.c      |  46 ++--
>  include/linux/device.h                   |   2 +
>  include/linux/property.h                 |  51 ++++
>  include/linux/usb/typec_mux.h            |  62 ++---
>  14 files changed, 903 insertions(+), 249 deletions(-)
> 
> 

All applied (but you know that already).

Thanks!




