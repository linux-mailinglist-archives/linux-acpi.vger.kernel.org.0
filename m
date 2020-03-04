Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56D3C178F21
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Mar 2020 12:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387832AbgCDLBn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 4 Mar 2020 06:01:43 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:44901 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387626AbgCDLBn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Mar 2020 06:01:43 -0500
Received: from 79.184.237.41.ipv4.supernova.orange.pl (79.184.237.41) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id 8be21b25fa4b7b50; Wed, 4 Mar 2020 12:01:41 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        rafael@kernel.org
Subject: Re: [RESEND PATCH 1/1] PM-runtime: Add pm_runtime_get_if_active
Date:   Wed, 04 Mar 2020 12:01:40 +0100
Message-ID: <6215597.6oLzOjGcya@kreacher>
In-Reply-To: <20200225093102.18277-1-sakari.ailus@linux.intel.com>
References: <20200225093102.18277-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tuesday, February 25, 2020 10:31:02 AM CET Sakari Ailus wrote:
> pm_runtime_get_if_in_use() bumps the usage count if the usage count is
> non-zero and the device's runtime PM status is active. This works for
> drivers that do not use autoidle, but for those that do, the function
> returns zero even when the device is active.
> 
> In order to maintain sane device state while the device is powered on in
> hope it'll be needed, pm_runtime_get_if_active(dev, true) returns greater
> than zero if the device was in active state when it was called, in which
> case it also increments the device's usage_count.
> 
> If the second argument of pm_runtime_get_if_active() is false, the function
> acts just as pm_runtime_get_if_in_use() does. This patch also makes the
> latter as a wrapper for the former.
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
> This time cc'ing linux-pm as well.
> 
>  Documentation/power/runtime_pm.rst |  6 +++++
>  drivers/base/power/runtime.c       | 36 ++++++++++++++++++++++--------
>  include/linux/pm_runtime.h         | 12 +++++++++-
>  3 files changed, 44 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/power/runtime_pm.rst b/Documentation/power/runtime_pm.rst
> index ab8406c84254..0553008b6279 100644
> --- a/Documentation/power/runtime_pm.rst
> +++ b/Documentation/power/runtime_pm.rst
> @@ -382,6 +382,12 @@ drivers/base/power/runtime.c and include/linux/pm_runtime.h:
>        nonzero, increment the counter and return 1; otherwise return 0 without
>        changing the counter
>  
> +  `int pm_runtime_get_if_active(struct device *dev, bool ign_usage_count);`
> +    - return -EINVAL if 'power.disable_depth' is nonzero; otherwise, if the
> +      runtime PM status is RPM_ACTIVE, and either ign_usage_count is true
> +      or the device's usage_count is non-zero, increment the counter and
> +      return 1; otherwise return 0 without changing the counter
> +
>    `void pm_runtime_put_noidle(struct device *dev);`
>      - decrement the device's usage counter
>  
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 16134a69bf6f..99c7da112c95 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -1087,29 +1087,47 @@ int __pm_runtime_resume(struct device *dev, int rpmflags)
>  EXPORT_SYMBOL_GPL(__pm_runtime_resume);
>  
>  /**
> - * pm_runtime_get_if_in_use - Conditionally bump up the device's usage counter.
> + * pm_runtime_get_if_active - Conditionally bump up the device's usage counter.
>   * @dev: Device to handle.
>   *
>   * Return -EINVAL if runtime PM is disabled for the device.
>   *
> - * If that's not the case and if the device's runtime PM status is RPM_ACTIVE
> - * and the runtime PM usage counter is nonzero, increment the counter and
> - * return 1.  Otherwise return 0 without changing the counter.
> + * Otherwise, if the device's runtime PM status is RPM_ACTIVE and either
> + * ign_usage_count is true or the device's usage_count is non-zero, increment
> + * the counter and return 1. Otherwise return 0 without changing the counter.
> + *
> + * If ign_usage_count is true, the function can be used to prevent suspending
> + * the device when its runtime PM status is RPM_ACTIVE.
> + *
> + * If ign_usage_count is false, the function can be used to prevent suspending
> + * the device when both its runtime PM status is RPM_ACTIVE and its usage_count
> + * is non-zero.
> + *
> + * The caller is resposible for putting the device's usage count when ther
> + * return value is greater than zero.
>   */
> -int pm_runtime_get_if_in_use(struct device *dev)
> +int pm_runtime_get_if_active(struct device *dev, bool ign_usage_count)
>  {
>  	unsigned long flags;
>  	int retval;
>  
>  	spin_lock_irqsave(&dev->power.lock, flags);
> -	retval = dev->power.disable_depth > 0 ? -EINVAL :
> -		dev->power.runtime_status == RPM_ACTIVE
> -			&& atomic_inc_not_zero(&dev->power.usage_count);
> +	if (dev->power.disable_depth > 0) {
> +		retval = -EINVAL;
> +	} else if (dev->power.runtime_status != RPM_ACTIVE) {
> +		retval = 0;
> +	} else if (ign_usage_count) {
> +		retval = 1;
> +		atomic_inc(&dev->power.usage_count);
> +	} else {
> +		retval = atomic_inc_not_zero(&dev->power.usage_count);
> +	}
>  	trace_rpm_usage_rcuidle(dev, 0);
>  	spin_unlock_irqrestore(&dev->power.lock, flags);
> +
>  	return retval;
>  }
> -EXPORT_SYMBOL_GPL(pm_runtime_get_if_in_use);
> +EXPORT_SYMBOL_GPL(pm_runtime_get_if_active);
>  
>  /**
>   * __pm_runtime_set_status - Set runtime PM status of a device.
> diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> index 22af69d237a6..3bdcbce8141a 100644
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -38,7 +38,7 @@ extern int pm_runtime_force_resume(struct device *dev);
>  extern int __pm_runtime_idle(struct device *dev, int rpmflags);
>  extern int __pm_runtime_suspend(struct device *dev, int rpmflags);
>  extern int __pm_runtime_resume(struct device *dev, int rpmflags);
> -extern int pm_runtime_get_if_in_use(struct device *dev);
> +extern int pm_runtime_get_if_active(struct device *dev, bool ign_usage_count);
>  extern int pm_schedule_suspend(struct device *dev, unsigned int delay);
>  extern int __pm_runtime_set_status(struct device *dev, unsigned int status);
>  extern int pm_runtime_barrier(struct device *dev);
> @@ -60,6 +60,11 @@ extern void pm_runtime_put_suppliers(struct device *dev);
>  extern void pm_runtime_new_link(struct device *dev);
>  extern void pm_runtime_drop_link(struct device *dev);
>  
> +static inline int pm_runtime_get_if_in_use(struct device *dev)
> +{
> +	return pm_runtime_get_if_active(dev, false);
> +}
> +
>  static inline void pm_suspend_ignore_children(struct device *dev, bool enable)
>  {
>  	dev->power.ignore_children = enable;
> @@ -143,6 +148,11 @@ static inline int pm_runtime_get_if_in_use(struct device *dev)
>  {
>  	return -EINVAL;
>  }
> +static inline int pm_runtime_get_if_active(struct device *dev,
> +					   bool ign_usage_count)
> +{
> +	return -EINVAL;
> +}
>  static inline int __pm_runtime_set_status(struct device *dev,
>  					    unsigned int status) { return 0; }
>  static inline int pm_runtime_barrier(struct device *dev) { return 0; }
> 

No concerns or objections seen, so applied (with modified changelog) as 5.7
material.

Thanks!




