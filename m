Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 296E315A79F
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2020 12:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbgBLLUR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 12 Feb 2020 06:20:17 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2412 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727947AbgBLLUR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 12 Feb 2020 06:20:17 -0500
Received: from LHREML710-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 7763F2A0E0C223C69696;
        Wed, 12 Feb 2020 11:20:14 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 LHREML710-CAH.china.huawei.com (10.201.108.33) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 12 Feb 2020 11:20:14 +0000
Received: from [127.0.0.1] (10.202.226.45) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 12 Feb
 2020 11:20:13 +0000
From:   John Garry <john.garry@huawei.com>
Subject: About PPTT find_acpi_cpu_topology_package()
To:     Jeremy Linton <jeremy.linton@arm.com>
CC:     "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "liuqi (BA)" <liuqi115@huawei.com>
Message-ID: <7a888a84-d4c5-2b49-05f3-29876d49cae6@huawei.com>
Date:   Wed, 12 Feb 2020 11:20:12 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.45]
X-ClientProxiedBy: lhreml720-chm.china.huawei.com (10.201.108.71) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Jeremy,

I have a question about $subject for you, since you wrote the code.

This function returns a unique identifier for the package, but would not 
be the logically indexed package id we would expect, like 0, 1, 2, ...

It returns of the offset in the PPTT of the topology physical CPU node.

So I may get something like this:

john@ubuntu:~$ more 
/sys/devices/system/cpu/cpu80/topology/physical_package_id
5418

For sure, this does not violate the ABI in 
Documentation/ABI/testing/sysfs-devices-system-cpu:

"physical_package_id: physical package id of cpu#. Typically	 
corresponds to a physical socket number, but the actual value		is 
architecture and platform dependent."

Question: Is there any reason for which we cannot assign an indexed 
package id to each package node?

Some userspace tools rely on a sane meaningful package id, like perf:

See tools/perf/util/cpumap.c:

int cpu_map__get_die(struct perf_cpu_map *map, int idx, void *data)
{
...

	s = cpu_map__get_socket(map, idx, data);
	if (s == -1)
		return -1;

	/*
	 * Encode socket in bit range 15:8
	 * die_id is relative to socket, and
	 * we need a global id. So we combine
	 * socket + die id
	 */
	if (WARN_ONCE(die_id >> 8, "The die id number is too big.\n"))
		return -1;

...

	return (s << 8) | (die_id & 0xff);
}

This can only deal with a socket id which fits in a byte. I'd rather not 
change this code if possible.

Thanks,
John
