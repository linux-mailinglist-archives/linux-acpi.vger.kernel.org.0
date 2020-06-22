Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7825203B5D
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Jun 2020 17:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbgFVPqt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 22 Jun 2020 11:46:49 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:45196 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729196AbgFVPqt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Jun 2020 11:46:49 -0400
Received: from 89-64-85-91.dynamic.chello.pl (89.64.85.91) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 5fcac8efa79cfb66; Mon, 22 Jun 2020 17:46:47 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org
Subject: Re: [PATCH] ACPI / property: use cached name in acpi_fwnode_get_named_child_node()
Date:   Mon, 22 Jun 2020 17:46:46 +0200
Message-ID: <2153046.FaeeqxahQX@kreacher>
In-Reply-To: <20200609132239.27272-1-heikki.krogerus@linux.intel.com>
References: <20200609132239.27272-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tuesday, June 9, 2020 3:22:39 PM CEST Heikki Krogerus wrote:
> There is no need to re-evaluate the object name.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  drivers/acpi/property.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index e601c4511a8b5..6941062272e0b 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -606,13 +606,7 @@ static struct fwnode_handle *
>  acpi_fwnode_get_named_child_node(const struct fwnode_handle *fwnode,
>  				 const char *childname)
>  {
> -	char name[ACPI_PATH_SEGMENT_LENGTH];
>  	struct fwnode_handle *child;
> -	struct acpi_buffer path;
> -	acpi_status status;
> -
> -	path.length = sizeof(name);
> -	path.pointer = name;
>  
>  	fwnode_for_each_child_node(fwnode, child) {
>  		if (is_acpi_data_node(child)) {
> @@ -621,12 +615,8 @@ acpi_fwnode_get_named_child_node(const struct fwnode_handle *fwnode,
>  			continue;
>  		}
>  
> -		status = acpi_get_name(ACPI_HANDLE_FWNODE(child),
> -				       ACPI_SINGLE_NAME, &path);
> -		if (ACPI_FAILURE(status))
> -			break;
> -
> -		if (!strncmp(name, childname, ACPI_NAMESEG_SIZE))
> +		if (!strncmp(acpi_device_bid(to_acpi_device_node(child)),
> +			     childname, ACPI_NAMESEG_SIZE))
>  			return child;
>  	}
>  
> 

Applied as 5.9 material, thanks!




