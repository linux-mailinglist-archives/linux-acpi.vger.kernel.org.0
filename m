Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C94792DC8
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Sep 2023 20:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235367AbjIESws (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 Sep 2023 14:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237265AbjIESwr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Sep 2023 14:52:47 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on20604.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::604])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEA4DF;
        Tue,  5 Sep 2023 11:52:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Th8sK2oMO6n/4aGF/2AMtNwEmvsbYeXz6VrPsBX258DRyZwS1BQ3BxFd12XzmOs/VI+njRiiQ6S6HVzNfH1PCp31JZzBtirCNj6LgX1oSJ/plpmK3SUYl7ASgzbCWs28j6pNuLC4pKvtI78SxQdc3Vpg2l7APOeH5iiwtDFF9hli9No1kb8oO2Bw0pwhgByXkHDn7006wqvVpFCfAJldrAdZpJU4JLM+jqKYyu2Bs75owdQNrpznLGBibGLheuGWJoBVbSmSMKU9k4ulRPTeRB0H0E/R8BdwXkbqH3jcetD4DP/tggXQQ/tMcfLTRbpeTSRbGONPTIQhSN7jaNEiew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=byCztN5xx7nNmAU032zfLHkRf8BnffCugvJ89tivUxs=;
 b=a4AH9sA8EY8br/sjMmTjn6Lr73EMBvA6qdryaILxrZ5AqJaEunotQOr7L48sbjT5Myl6qfqPFSuE9nQQBlWQQQ0lU79RWQC9sNu9+QtqNDcqmjN3gD9fBXnQr0/UOhX+Zw8Sy6JbAjedOsPN/EUbzY71x4WwhUZw4BsPlFdSI8LsYSie9BXvdIIXzaGShgydE7UreMP1MxaTdtMqKezTxITsFmPRtZY47mr7LwS/4C6rIqFGKPNW6T9CzxzqPVfMY7K32Nnt2q0UBlCfxH4Jlky08ftkjviy8w0pNURs5nXclMqks1/RHapOvIWoJjT0MwfBso7Kvj4GMpwFmQki9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=byCztN5xx7nNmAU032zfLHkRf8BnffCugvJ89tivUxs=;
 b=IVYz6y0kW0Sl9yReWgVVsnJWNSlofvn+gWkMrPO/0JEqXyAhXVlBNcJwQ3y1Q34JW+yeh4IHcV8ufg+g+H7AQI0/EvRmsPBu/qky8ZVzoucfiDeppcUqBsrkIPnSVLX75FkrN0Ch55R2cgsaqCDKESCSBbXcpC/3rWmFbC9Oogg=
Received: from SJ2PR07CA0010.namprd07.prod.outlook.com (2603:10b6:a03:505::27)
 by MW4PR12MB7287.namprd12.prod.outlook.com (2603:10b6:303:22c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 18:44:36 +0000
Received: from CO1PEPF000044EF.namprd05.prod.outlook.com
 (2603:10b6:a03:505:cafe::56) by SJ2PR07CA0010.outlook.office365.com
 (2603:10b6:a03:505::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33 via Frontend
 Transport; Tue, 5 Sep 2023 18:44:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044EF.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Tue, 5 Sep 2023 18:44:36 +0000
Received: from bcheatha-HP-EliteBook-845-G8-Notebook-PC.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 5 Sep 2023 13:44:35 -0500
From:   Ben Cheatham <Benjamin.Cheatham@amd.com>
To:     <rafael@kernel.org>, <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>
CC:     <bhelgaas@google.com>, <benjamin.cheatham@amd.com>,
        <yazen.ghannam@amd.com>
Subject: [PATCH v3 1/3] CXL, PCIE: Add cxl_rcrb_addr file to dport_dev
Date:   Tue, 5 Sep 2023 13:44:04 -0500
Message-ID: <20230905184406.135851-2-Benjamin.Cheatham@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230905184406.135851-1-Benjamin.Cheatham@amd.com>
References: <20230905184406.135851-1-Benjamin.Cheatham@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EF:EE_|MW4PR12MB7287:EE_
X-MS-Office365-Filtering-Correlation-Id: 647301e7-7605-4e8e-5660-08dbae402776
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3mN9V1PDVqBln+1yi+XCSYUVJH9r0+s3alywVSqtYo2Qs6NiYu+2fqHEpw63h2ugu0QRmm3nn/kb/OEeE5sK4vaKUurdFFzkPKvlSQ0zPtS2ItrnyVKCMp1TSxHH/V/TuuITWGGa7j9vG05Xco0r62MEC98P1K3UMk601xmAsQESz+lOkDPfxdHBgbdx7iI3gbqBzRHfOBC2+mkgPz4LMC6B0uTbLlHB++fyspTUKoB+jPOpt6TEp2tT6wKlTseczUkx4pQAGu6LB9tlSRsdpRm4m0QsRSPGHAAwrHXxRF9Ohb17resv8PJcDRea37zeuiIHpCkimo7Zj3GmB9Xb8lycQabK0fs143gMJrFMPIsNxJxrquM3vqYDU4uC3PkUEybDy33a6/MQ3FdvDaIS8szy05db+KhnknEWw7aRNdssyuffV0xf/2XkmGGxXWL974XBq44LdMxIzTRTTr1m7zJIlmhiatoXyUgDcAlyVQJkDNZY5pmZrbAsoQxIxzOx3SI2yaFb4AKYAWYe6NiDVstA0r13JxgSLMtDsPhHnqhHK0S8FS6RUKi3adsurXBEQWLwHtHL6di09oBoE35FEmxTWHETB1xmc5ZHoOxuzzGhskxSf84UeFPYCeWRRT6SaRpBWfjpX16qs7WN/kTqhflO9bzCnQZ2adV+Pfb04Sl7Uo1YMel8MuoiAobdVVHDjQRm5y4EKa7TzvzBT2EhlNNZWQZdhnsD2bk22k2Y+4lZpGJfEVJwSTTh9u4Eh33QbUAp3q+dRR3QWTJMmdr5fQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(39860400002)(396003)(186009)(1800799009)(82310400011)(451199024)(40470700004)(36840700001)(46966006)(40460700003)(40480700001)(6666004)(7696005)(478600001)(36860700001)(356005)(47076005)(81166007)(2906002)(110136005)(1076003)(2616005)(426003)(26005)(336012)(16526019)(83380400001)(86362001)(36756003)(82740400003)(5660300002)(54906003)(70586007)(316002)(70206006)(8936002)(4326008)(8676002)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 18:44:36.4857
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 647301e7-7605-4e8e-5660-08dbae402776
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7287
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add cxl_rcrb_addr to the dport_dev (normally represented by a pcie
device) for CXL RCH root ports. The file will print the RCRB base
MMIO address of the root port when read and will be used by
users looking to inject CXL EINJ error types for RCH hosts.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 Documentation/ABI/testing/sysfs-bus-cxl |  8 ++++++
 drivers/cxl/acpi.c                      |  2 ++
 drivers/cxl/core/port.c                 | 33 +++++++++++++++++++++++++
 drivers/cxl/cxl.h                       |  2 ++
 4 files changed, 45 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 087f762ebfd5..a7d169235543 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -177,6 +177,14 @@ Description:
 		integer reflects the hardware port unique-id used in the
 		hardware decoder target list.
 
+What:		/sys/bus/cxl/devices/portX/dportY/cxl_rcrb_addr
+Date:		August, 2023
+KernelVersion:	v6.6
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) The 'cxl_rcrb_addr' device file gives the MMIO base address
+		of the RCRB of the corresponding CXL 1.1 downstream port. Only
+		present for CXL 1.1 dports.
 
 What:		/sys/bus/cxl/devices/decoderX.Y
 Date:		June, 2021
diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index d1c559879dcc..3e2ca946bf47 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -676,6 +676,8 @@ static int cxl_acpi_probe(struct platform_device *pdev)
 	if (IS_ERR(root_port))
 		return PTR_ERR(root_port);
 
+	set_cxl_root(root_port);
+
 	rc = bus_for_each_dev(adev->dev.bus, NULL, root_port,
 			      add_host_bridge_dport);
 	if (rc < 0)
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 724be8448eb4..b69fd1c1d5d6 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -875,6 +875,14 @@ struct cxl_port *find_cxl_root(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(find_cxl_root, CXL);
 
+static struct cxl_port *cxl_root;
+
+void set_cxl_root(struct cxl_port *root_port)
+{
+	cxl_root = root_port;
+}
+EXPORT_SYMBOL_NS_GPL(set_cxl_root, CXL);
+
 static struct cxl_dport *find_dport(struct cxl_port *port, int id)
 {
 	struct cxl_dport *dport;
@@ -930,11 +938,30 @@ static void cond_cxl_root_unlock(struct cxl_port *port)
 		device_unlock(&port->dev);
 }
 
+static ssize_t cxl_rcrb_addr_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct cxl_dport *dport;
+
+	if (!cxl_root)
+		return -ENODEV;
+
+	dport = cxl_find_dport_by_dev(cxl_root, dev);
+	if (!dport)
+		return -ENODEV;
+
+	return sysfs_emit(buf, "0x%llx\n", dport->rcrb.base);
+}
+DEVICE_ATTR_RO(cxl_rcrb_addr);
+
 static void cxl_dport_remove(void *data)
 {
 	struct cxl_dport *dport = data;
 	struct cxl_port *port = dport->port;
 
+	if (dport->rch)
+		device_remove_file(dport->dport_dev, &dev_attr_cxl_rcrb_addr);
+
 	xa_erase(&port->dports, (unsigned long) dport->dport_dev);
 	put_device(dport->dport_dev);
 }
@@ -1021,6 +1048,12 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 	if (rc)
 		return ERR_PTR(rc);
 
+	if (dport->rch && dport->rcrb.base != CXL_RESOURCE_NONE) {
+		rc = device_create_file(dport_dev, &dev_attr_cxl_rcrb_addr);
+		if (rc)
+			return ERR_PTR(rc);
+	}
+
 	return dport;
 }
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 76d92561af29..4d5bce4bae7e 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -690,6 +690,8 @@ struct cxl_port *devm_cxl_add_port(struct device *host,
 				   resource_size_t component_reg_phys,
 				   struct cxl_dport *parent_dport);
 struct cxl_port *find_cxl_root(struct cxl_port *port);
+void set_cxl_root(struct cxl_port *root_port);
+
 int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd);
 void cxl_bus_rescan(void);
 void cxl_bus_drain(void);
-- 
2.34.1

