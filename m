Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A034D178F06
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Mar 2020 11:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbgCDK5r (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 4 Mar 2020 05:57:47 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:64346 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728953AbgCDK5r (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Mar 2020 05:57:47 -0500
Received: from 79.184.237.41.ipv4.supernova.orange.pl (79.184.237.41) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id d6ba944d08654965; Wed, 4 Mar 2020 11:57:44 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     qiwuchen55@gmail.com
Cc:     lenb@kernel.org, linux-acpi@vger.kernel.org,
        chenqiwu <chenqiwu@xiaomi.com>
Subject: Re: [PATCH] acpi: list_for_each_safe() -> list_for_each_entry_safe()
Date:   Wed, 04 Mar 2020 11:57:44 +0100
Message-ID: <2166554.vSs1JGyd92@kreacher>
In-Reply-To: <1582438102-29488-1-git-send-email-qiwuchen55@gmail.com>
References: <1582438102-29488-1-git-send-email-qiwuchen55@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sunday, February 23, 2020 7:08:22 AM CET qiwuchen55@gmail.com wrote:
> From: chenqiwu <chenqiwu@xiaomi.com>
> 
> Use list_for_each_entry_safe() instead of list_for_each_safe()
> to simplify code.
> 
> Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
> ---
>  drivers/acpi/proc.c   | 14 ++++++--------
>  drivers/acpi/wakeup.c | 24 +++++++++---------------
>  2 files changed, 15 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/acpi/proc.c b/drivers/acpi/proc.c
> index 0e62ef2..7892980 100644
> --- a/drivers/acpi/proc.c
> +++ b/drivers/acpi/proc.c
> @@ -22,14 +22,13 @@
>  static int
>  acpi_system_wakeup_device_seq_show(struct seq_file *seq, void *offset)
>  {
> -	struct list_head *node, *next;
> +	struct acpi_device *dev, *tmp;
>  
>  	seq_printf(seq, "Device\tS-state\t  Status   Sysfs node\n");
>  
>  	mutex_lock(&acpi_device_lock);
> -	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
> -		struct acpi_device *dev =
> -		    container_of(node, struct acpi_device, wakeup_list);
> +	list_for_each_entry_safe(dev, tmp, &acpi_wakeup_device_list,
> +				 wakeup_list) {
>  		struct acpi_device_physical_node *entry;
>  
>  		if (!dev->wakeup.flags.valid)
> @@ -96,7 +95,7 @@ static void physical_device_enable_wakeup(struct acpi_device *adev)
>  				const char __user * buffer,
>  				size_t count, loff_t * ppos)
>  {
> -	struct list_head *node, *next;
> +	struct acpi_device *dev, *tmp;
>  	char strbuf[5];
>  	char str[5] = "";
>  
> @@ -109,9 +108,8 @@ static void physical_device_enable_wakeup(struct acpi_device *adev)
>  	sscanf(strbuf, "%s", str);
>  
>  	mutex_lock(&acpi_device_lock);
> -	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
> -		struct acpi_device *dev =
> -		    container_of(node, struct acpi_device, wakeup_list);
> +	list_for_each_entry_safe(dev, tmp, &acpi_wakeup_device_list,
> +				 wakeup_list) {
>  		if (!dev->wakeup.flags.valid)
>  			continue;
>  
> diff --git a/drivers/acpi/wakeup.c b/drivers/acpi/wakeup.c
> index 9614126..c28244d 100644
> --- a/drivers/acpi/wakeup.c
> +++ b/drivers/acpi/wakeup.c
> @@ -30,12 +30,10 @@
>   */
>  void acpi_enable_wakeup_devices(u8 sleep_state)
>  {
> -	struct list_head *node, *next;
> -
> -	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
> -		struct acpi_device *dev =
> -			container_of(node, struct acpi_device, wakeup_list);
> +	struct acpi_device *dev, *tmp;
>  
> +	list_for_each_entry_safe(dev, tmp, &acpi_wakeup_device_list,
> +				 wakeup_list) {
>  		if (!dev->wakeup.flags.valid
>  		    || sleep_state > (u32) dev->wakeup.sleep_state
>  		    || !(device_may_wakeup(&dev->dev)
> @@ -57,12 +55,10 @@ void acpi_enable_wakeup_devices(u8 sleep_state)
>   */
>  void acpi_disable_wakeup_devices(u8 sleep_state)
>  {
> -	struct list_head *node, *next;
> -
> -	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
> -		struct acpi_device *dev =
> -			container_of(node, struct acpi_device, wakeup_list);
> +	struct acpi_device *dev, *tmp;
>  
> +	list_for_each_entry_safe(dev, tmp, &acpi_wakeup_device_list,
> +				 wakeup_list) {
>  		if (!dev->wakeup.flags.valid
>  		    || sleep_state > (u32) dev->wakeup.sleep_state
>  		    || !(device_may_wakeup(&dev->dev)
> @@ -79,13 +75,11 @@ void acpi_disable_wakeup_devices(u8 sleep_state)
>  
>  int __init acpi_wakeup_device_init(void)
>  {
> -	struct list_head *node, *next;
> +	struct acpi_device *dev, *tmp;
>  
>  	mutex_lock(&acpi_device_lock);
> -	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
> -		struct acpi_device *dev = container_of(node,
> -						       struct acpi_device,
> -						       wakeup_list);
> +	list_for_each_entry_safe(dev, tmp, &acpi_wakeup_device_list,
> +				 wakeup_list) {
>  		if (device_can_wakeup(&dev->dev)) {
>  			/* Button GPEs are supposed to be always enabled. */
>  			acpi_enable_gpe(dev->wakeup.gpe_device,
> 

Applied with modified subject and changelog as 5.7 material, thanks!



