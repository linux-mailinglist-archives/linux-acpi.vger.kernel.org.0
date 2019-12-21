Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF5521287B6
	for <lists+linux-acpi@lfdr.de>; Sat, 21 Dec 2019 07:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725838AbfLUGOU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 21 Dec 2019 01:14:20 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:52656
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725773AbfLUGOT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 21 Dec 2019 01:14:19 -0500
X-IronPort-AV: E=Sophos;i="5.69,338,1571695200"; 
   d="scan'208";a="333931587"
Received: from abo-154-110-68.mrs.modulonet.fr (HELO hadrien) ([85.68.110.154])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Dec 2019 07:14:13 +0100
Date:   Sat, 21 Dec 2019 07:14:12 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Niklas Cassel <niklas.cassel@linaro.org>
cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        devel@acpica.org, linux-acpi@vger.kernel.org,
        kbuild-all@lists.01.org
Subject: [pm:bleeding-edge 59/60] drivers/power/avs/qcom-cpr.c:1539:5-21:
 WARNING: Unsigned expression compared with zero: drv -> num_corners < 0
 (fwd)
Message-ID: <alpine.DEB.2.21.1912210710140.2559@hadrien>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Please see line 1539.  It seems that the num_corners field is unsigned, so
it will not be less than 0.

julia



---------- Forwarded message ----------
Date: Sat, 21 Dec 2019 06:52:19 +0800
From: kbuild test robot <lkp@intel.com>
To: kbuild@lists.01.org
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: [pm:bleeding-edge 59/60] drivers/power/avs/qcom-cpr.c:1539:5-21:
    WARNING: Unsigned expression compared with zero: drv -> num_corners < 0

CC: kbuild-all@lists.01.org
CC: linux-acpi@vger.kernel.org
CC: devel@acpica.org
CC: linux-pm@vger.kernel.org
TO: Niklas Cassel <niklas.cassel@linaro.org>
CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: "Jorge Ramirez-Ortiz" <jorge.ramirez-ortiz@linaro.org>
CC: Bjorn Andersson <bjorn.andersson@linaro.org>
CC: Ulf Hansson <ulf.hansson@linaro.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   89eba9e38dc4ed4576eaf7711c60403568663291
commit: bf6910abf54871b0e976e52f56fb3b3dd1b90e48 [59/60] power: avs: Add support for CPR (Core Power Reduction)
:::::: branch date: 13 hours ago
:::::: commit date: 13 hours ago

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@lip6.fr>

>> drivers/power/avs/qcom-cpr.c:1539:5-21: WARNING: Unsigned expression compared with zero: drv -> num_corners < 0

# https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?id=bf6910abf54871b0e976e52f56fb3b3dd1b90e48
git remote add pm https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git
git remote update pm
git checkout bf6910abf54871b0e976e52f56fb3b3dd1b90e48
vim +1539 drivers/power/avs/qcom-cpr.c

bf6910abf54871 Niklas Cassel 2019-11-29  1487
bf6910abf54871 Niklas Cassel 2019-11-29  1488  static int cpr_pd_attach_dev(struct generic_pm_domain *domain,
bf6910abf54871 Niklas Cassel 2019-11-29  1489  			     struct device *dev)
bf6910abf54871 Niklas Cassel 2019-11-29  1490  {
bf6910abf54871 Niklas Cassel 2019-11-29  1491  	struct cpr_drv *drv = container_of(domain, struct cpr_drv, pd);
bf6910abf54871 Niklas Cassel 2019-11-29  1492  	const struct acc_desc *acc_desc = drv->acc_desc;
bf6910abf54871 Niklas Cassel 2019-11-29  1493  	int ret = 0;
bf6910abf54871 Niklas Cassel 2019-11-29  1494
bf6910abf54871 Niklas Cassel 2019-11-29  1495  	mutex_lock(&drv->lock);
bf6910abf54871 Niklas Cassel 2019-11-29  1496
bf6910abf54871 Niklas Cassel 2019-11-29  1497  	dev_dbg(drv->dev, "attach callback for: %s\n", dev_name(dev));
bf6910abf54871 Niklas Cassel 2019-11-29  1498
bf6910abf54871 Niklas Cassel 2019-11-29  1499  	/*
bf6910abf54871 Niklas Cassel 2019-11-29  1500  	 * This driver only supports scaling voltage for a CPU cluster
bf6910abf54871 Niklas Cassel 2019-11-29  1501  	 * where all CPUs in the cluster share a single regulator.
bf6910abf54871 Niklas Cassel 2019-11-29  1502  	 * Therefore, save the struct device pointer only for the first
bf6910abf54871 Niklas Cassel 2019-11-29  1503  	 * CPU device that gets attached. There is no need to do any
bf6910abf54871 Niklas Cassel 2019-11-29  1504  	 * additional initialization when further CPUs get attached.
bf6910abf54871 Niklas Cassel 2019-11-29  1505  	 */
bf6910abf54871 Niklas Cassel 2019-11-29  1506  	if (drv->attached_cpu_dev)
bf6910abf54871 Niklas Cassel 2019-11-29  1507  		goto unlock;
bf6910abf54871 Niklas Cassel 2019-11-29  1508
bf6910abf54871 Niklas Cassel 2019-11-29  1509  	/*
bf6910abf54871 Niklas Cassel 2019-11-29  1510  	 * cpr_scale_voltage() requires the direction (if we are changing
bf6910abf54871 Niklas Cassel 2019-11-29  1511  	 * to a higher or lower OPP). The first time
bf6910abf54871 Niklas Cassel 2019-11-29  1512  	 * cpr_set_performance_state() is called, there is no previous
bf6910abf54871 Niklas Cassel 2019-11-29  1513  	 * performance state defined. Therefore, we call
bf6910abf54871 Niklas Cassel 2019-11-29  1514  	 * cpr_find_initial_corner() that gets the CPU clock frequency
bf6910abf54871 Niklas Cassel 2019-11-29  1515  	 * set by the bootloader, so that we can determine the direction
bf6910abf54871 Niklas Cassel 2019-11-29  1516  	 * the first time cpr_set_performance_state() is called.
bf6910abf54871 Niklas Cassel 2019-11-29  1517  	 */
bf6910abf54871 Niklas Cassel 2019-11-29  1518  	drv->cpu_clk = devm_clk_get(dev, NULL);
bf6910abf54871 Niklas Cassel 2019-11-29  1519  	if (IS_ERR(drv->cpu_clk)) {
bf6910abf54871 Niklas Cassel 2019-11-29  1520  		ret = PTR_ERR(drv->cpu_clk);
bf6910abf54871 Niklas Cassel 2019-11-29  1521  		if (ret != -EPROBE_DEFER)
bf6910abf54871 Niklas Cassel 2019-11-29  1522  			dev_err(drv->dev, "could not get cpu clk: %d\n", ret);
bf6910abf54871 Niklas Cassel 2019-11-29  1523  		goto unlock;
bf6910abf54871 Niklas Cassel 2019-11-29  1524  	}
bf6910abf54871 Niklas Cassel 2019-11-29  1525  	drv->attached_cpu_dev = dev;
bf6910abf54871 Niklas Cassel 2019-11-29  1526
bf6910abf54871 Niklas Cassel 2019-11-29  1527  	dev_dbg(drv->dev, "using cpu clk from: %s\n",
bf6910abf54871 Niklas Cassel 2019-11-29  1528  		dev_name(drv->attached_cpu_dev));
bf6910abf54871 Niklas Cassel 2019-11-29  1529
bf6910abf54871 Niklas Cassel 2019-11-29  1530  	/*
bf6910abf54871 Niklas Cassel 2019-11-29  1531  	 * Everything related to (virtual) corners has to be initialized
bf6910abf54871 Niklas Cassel 2019-11-29  1532  	 * here, when attaching to the power domain, since we need to know
bf6910abf54871 Niklas Cassel 2019-11-29  1533  	 * the maximum frequency for each fuse corner, and this is only
bf6910abf54871 Niklas Cassel 2019-11-29  1534  	 * available after the cpufreq driver has attached to us.
bf6910abf54871 Niklas Cassel 2019-11-29  1535  	 * The reason for this is that we need to know the highest
bf6910abf54871 Niklas Cassel 2019-11-29  1536  	 * frequency associated with each fuse corner.
bf6910abf54871 Niklas Cassel 2019-11-29  1537  	 */
bf6910abf54871 Niklas Cassel 2019-11-29  1538  	drv->num_corners = dev_pm_opp_get_opp_count(&drv->pd.dev);
bf6910abf54871 Niklas Cassel 2019-11-29 @1539  	if (drv->num_corners < 0) {
bf6910abf54871 Niklas Cassel 2019-11-29  1540  		ret = drv->num_corners;
bf6910abf54871 Niklas Cassel 2019-11-29  1541  		goto unlock;
bf6910abf54871 Niklas Cassel 2019-11-29  1542  	}
bf6910abf54871 Niklas Cassel 2019-11-29  1543  	if (drv->num_corners < 2) {
bf6910abf54871 Niklas Cassel 2019-11-29  1544  		dev_err(drv->dev, "need at least 2 OPPs to use CPR\n");
bf6910abf54871 Niklas Cassel 2019-11-29  1545  		ret = -EINVAL;
bf6910abf54871 Niklas Cassel 2019-11-29  1546  		goto unlock;
bf6910abf54871 Niklas Cassel 2019-11-29  1547  	}
bf6910abf54871 Niklas Cassel 2019-11-29  1548
bf6910abf54871 Niklas Cassel 2019-11-29  1549  	dev_dbg(drv->dev, "number of OPPs: %d\n", drv->num_corners);
bf6910abf54871 Niklas Cassel 2019-11-29  1550
bf6910abf54871 Niklas Cassel 2019-11-29  1551  	drv->corners = devm_kcalloc(drv->dev, drv->num_corners,
bf6910abf54871 Niklas Cassel 2019-11-29  1552  				    sizeof(*drv->corners),
bf6910abf54871 Niklas Cassel 2019-11-29  1553  				    GFP_KERNEL);
bf6910abf54871 Niklas Cassel 2019-11-29  1554  	if (!drv->corners) {
bf6910abf54871 Niklas Cassel 2019-11-29  1555  		ret = -ENOMEM;
bf6910abf54871 Niklas Cassel 2019-11-29  1556  		goto unlock;
bf6910abf54871 Niklas Cassel 2019-11-29  1557  	}
bf6910abf54871 Niklas Cassel 2019-11-29  1558
bf6910abf54871 Niklas Cassel 2019-11-29  1559  	ret = cpr_corner_init(drv);
bf6910abf54871 Niklas Cassel 2019-11-29  1560  	if (ret)
bf6910abf54871 Niklas Cassel 2019-11-29  1561  		goto unlock;
bf6910abf54871 Niklas Cassel 2019-11-29  1562
bf6910abf54871 Niklas Cassel 2019-11-29  1563  	cpr_set_loop_allowed(drv);
bf6910abf54871 Niklas Cassel 2019-11-29  1564
bf6910abf54871 Niklas Cassel 2019-11-29  1565  	ret = cpr_init_parameters(drv);
bf6910abf54871 Niklas Cassel 2019-11-29  1566  	if (ret)
bf6910abf54871 Niklas Cassel 2019-11-29  1567  		goto unlock;
bf6910abf54871 Niklas Cassel 2019-11-29  1568
bf6910abf54871 Niklas Cassel 2019-11-29  1569  	/* Configure CPR HW but keep it disabled */
bf6910abf54871 Niklas Cassel 2019-11-29  1570  	ret = cpr_config(drv);
bf6910abf54871 Niklas Cassel 2019-11-29  1571  	if (ret)
bf6910abf54871 Niklas Cassel 2019-11-29  1572  		goto unlock;
bf6910abf54871 Niklas Cassel 2019-11-29  1573
bf6910abf54871 Niklas Cassel 2019-11-29  1574  	ret = cpr_find_initial_corner(drv);
bf6910abf54871 Niklas Cassel 2019-11-29  1575  	if (ret)
bf6910abf54871 Niklas Cassel 2019-11-29  1576  		goto unlock;
bf6910abf54871 Niklas Cassel 2019-11-29  1577
bf6910abf54871 Niklas Cassel 2019-11-29  1578  	if (acc_desc->config)
bf6910abf54871 Niklas Cassel 2019-11-29  1579  		regmap_multi_reg_write(drv->tcsr, acc_desc->config,
bf6910abf54871 Niklas Cassel 2019-11-29  1580  				       acc_desc->num_regs_per_fuse);
bf6910abf54871 Niklas Cassel 2019-11-29  1581
bf6910abf54871 Niklas Cassel 2019-11-29  1582  	/* Enable ACC if required */
bf6910abf54871 Niklas Cassel 2019-11-29  1583  	if (acc_desc->enable_mask)
bf6910abf54871 Niklas Cassel 2019-11-29  1584  		regmap_update_bits(drv->tcsr, acc_desc->enable_reg,
bf6910abf54871 Niklas Cassel 2019-11-29  1585  				   acc_desc->enable_mask,
bf6910abf54871 Niklas Cassel 2019-11-29  1586  				   acc_desc->enable_mask);
bf6910abf54871 Niklas Cassel 2019-11-29  1587
bf6910abf54871 Niklas Cassel 2019-11-29  1588  unlock:
bf6910abf54871 Niklas Cassel 2019-11-29  1589  	mutex_unlock(&drv->lock);
bf6910abf54871 Niklas Cassel 2019-11-29  1590
bf6910abf54871 Niklas Cassel 2019-11-29  1591  	return ret;
bf6910abf54871 Niklas Cassel 2019-11-29  1592  }
bf6910abf54871 Niklas Cassel 2019-11-29  1593

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
