Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85835A154F
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2019 12:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfH2KBp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 29 Aug 2019 06:01:45 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57458 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfH2KBo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 29 Aug 2019 06:01:44 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7T9xONa068680;
        Thu, 29 Aug 2019 10:01:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=zkvRpa/K3WJumV596fyuMKitaSxsrbHTsqVmSpQPotM=;
 b=c2bCkBgyoOtkVK/xIGPXM8PHo5Oh6WAT+PNms/EV79b0VHRR+5vf4AndEcKgHBc5MB2o
 OdF2EGM31n4yBFMosUp8VbPoEVNII1FPTcufiy8V+vQFacdC60X3siO1vxsxXrNtAgpC
 RJQdVdfGFhDSMSQAgIQ7ABcP3xRpX0n1I0PJ2rxWfzUAO+Lbgc4envxmnUN4nRqXsOa5
 I6KCeOMAdC2cvfkbRfprCXyTN4KLzgmvjlYgscK1Zpsfufvmh1GIkYt2MmAN8oRy0wXj
 VMur2KlvnD/G/Q2qsZkFQaGtfkHpWFP47hQz9dfk7aBLQbh2JHNDpqbADBtO3eTgADYq 1A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2upcfwg27h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Aug 2019 10:01:25 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7T9rZ08022150;
        Thu, 29 Aug 2019 09:56:25 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2unteurs3p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Aug 2019 09:56:24 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7T9uMwa022689;
        Thu, 29 Aug 2019 09:56:23 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 29 Aug 2019 02:56:22 -0700
Date:   Thu, 29 Aug 2019 12:56:14 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@01.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     kbuild-all@01.org, linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [pm:devprop 1/4] drivers/base/swnode.c:656
 software_node_find_by_name() error: uninitialized symbol 'swnode'.
Message-ID: <20190829095613.GD8372@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9363 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908290108
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9363 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908290110
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/rafael/linux-pm.git devprop
head:   149f3b87840e7d292ad059f5fc23f1fa2fc98b9e
commit: 1666faedb567d03cde1d656ae24c6cc253e67373 [1/4] software node: Add software_node_find_by_name()

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/base/swnode.c:656 software_node_find_by_name() error: uninitialized symbol 'swnode'.

Old smatch warnings:
drivers/base/swnode.c:71 software_node_to_swnode() error: uninitialized symbol 'swnode'.

git remote add pm https://kernel.googlesource.com/pub/scm/linux/kernel/git/rafael/linux-pm.git
git remote update pm
git checkout 1666faedb567d03cde1d656ae24c6cc253e67373
vim +/swnode +656 drivers/base/swnode.c

59abd83672f70c Heikki Krogerus 2018-11-09  622  
1666faedb567d0 Heikki Krogerus 2019-08-19  623  /**
1666faedb567d0 Heikki Krogerus 2019-08-19  624   * software_node_find_by_name - Find software node by name
1666faedb567d0 Heikki Krogerus 2019-08-19  625   * @parent: Parent of the software node
1666faedb567d0 Heikki Krogerus 2019-08-19  626   * @name: Name of the software node
1666faedb567d0 Heikki Krogerus 2019-08-19  627   *
1666faedb567d0 Heikki Krogerus 2019-08-19  628   * The function will find a node that is child of @parent and that is named
1666faedb567d0 Heikki Krogerus 2019-08-19  629   * @name. If no node is found, the function returns NULL.
1666faedb567d0 Heikki Krogerus 2019-08-19  630   *
1666faedb567d0 Heikki Krogerus 2019-08-19  631   * NOTE: you will need to drop the reference with fwnode_handle_put() after use.
1666faedb567d0 Heikki Krogerus 2019-08-19  632   */
1666faedb567d0 Heikki Krogerus 2019-08-19  633  const struct software_node *
1666faedb567d0 Heikki Krogerus 2019-08-19  634  software_node_find_by_name(const struct software_node *parent, const char *name)
1666faedb567d0 Heikki Krogerus 2019-08-19  635  {
1666faedb567d0 Heikki Krogerus 2019-08-19  636  	struct swnode *swnode;
1666faedb567d0 Heikki Krogerus 2019-08-19  637  	struct kobject *k;
1666faedb567d0 Heikki Krogerus 2019-08-19  638  
1666faedb567d0 Heikki Krogerus 2019-08-19  639  	if (!name)
1666faedb567d0 Heikki Krogerus 2019-08-19  640  		return NULL;
1666faedb567d0 Heikki Krogerus 2019-08-19  641  
1666faedb567d0 Heikki Krogerus 2019-08-19  642  	spin_lock(&swnode_kset->list_lock);
1666faedb567d0 Heikki Krogerus 2019-08-19  643  
1666faedb567d0 Heikki Krogerus 2019-08-19  644  	list_for_each_entry(k, &swnode_kset->list, entry) {

Can this list be empty?  Probably not, but if so then "swnode" could
be uninitialized.

1666faedb567d0 Heikki Krogerus 2019-08-19  645  		swnode = kobj_to_swnode(k);
1666faedb567d0 Heikki Krogerus 2019-08-19  646  		if (parent == swnode->node->parent && swnode->node->name &&
1666faedb567d0 Heikki Krogerus 2019-08-19  647  		    !strcmp(name, swnode->node->name)) {
1666faedb567d0 Heikki Krogerus 2019-08-19  648  			kobject_get(&swnode->kobj);
1666faedb567d0 Heikki Krogerus 2019-08-19  649  			break;
1666faedb567d0 Heikki Krogerus 2019-08-19  650  		}
1666faedb567d0 Heikki Krogerus 2019-08-19  651  		swnode = NULL;
1666faedb567d0 Heikki Krogerus 2019-08-19  652  	}
1666faedb567d0 Heikki Krogerus 2019-08-19  653  
1666faedb567d0 Heikki Krogerus 2019-08-19  654  	spin_unlock(&swnode_kset->list_lock);
1666faedb567d0 Heikki Krogerus 2019-08-19  655  
1666faedb567d0 Heikki Krogerus 2019-08-19 @656  	return swnode ? swnode->node : NULL;
1666faedb567d0 Heikki Krogerus 2019-08-19  657  }
1666faedb567d0 Heikki Krogerus 2019-08-19  658  EXPORT_SYMBOL_GPL(software_node_find_by_name);
1666faedb567d0 Heikki Krogerus 2019-08-19  659  

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
